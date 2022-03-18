//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    // MARK: - Properties for View
    @IBOutlet weak var controlPanelView: ControlPanelView!
    @IBOutlet weak var planeView: PlaneView!
    
    // MARK: - Property for Model
    private let plane = Plane()
    private var shapeMap = [Shape: ShapeViewable]()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDelegate()
        self.setObservers()
    }
    
    // MARK: - UI Configuration Methods
    private func configureDelegate() {
        self.planeView.delegate = self
        self.controlPanelView.delegate = self
    }
    
    private func setObservers() {
        NotificationCenter.default.addObserver(forName: .RectangleModelDidCreated, object: nil, queue: .main, using: { notification in
            guard let shape = notification.object as? Shape else { return }
            self.createShapeView(ofClass: ColoredRectangleView.self, with: shape)
        })
        NotificationCenter.default.addObserver(forName: .RectangleModelDidUpdated, object: nil, queue: .main, using: self.shapeModelDidChanged)
        
        NotificationCenter.default.addObserver(forName: .ImageRectangleModelDidCreated, object: nil, queue: .main, using: { notification in
            guard let shape = notification.object as? Shape else { return }
            self.createShapeView(ofClass: ImageRectangleView.self, with: shape)
        })
        NotificationCenter.default.addObserver(forName: .RectangleModelDidUpdated, object: nil, queue: .main, using: self.shapeModelDidChanged)
        
        NotificationCenter.default.addObserver(forName: .PlaneDidSelectItem, object: self.plane, queue: .main, using: self.planeDidSelectItem)
        NotificationCenter.default.addObserver(forName: .PlaneDidUnselectItem, object: self.plane, queue: .main, using: self.planeDidUnselectItem)
    }
}

// MARK: - PlaneView To ViewController
extension ViewController: PlaneViewDelegate {
    func planeViewDidTapped(_ sender: UITapGestureRecognizer) {
        self.plane.unselectItem()
    }
    
    func planeViewDidPressColoredRectangleAddButton() {
        let shape = RectangleFactory.makeRandomRectangle()
        plane.append(item: shape)
    }
    
    func planeViewDidPressImageRectangleAddButton() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        
        configuration.filter = .images
        configuration.selectionLimit = 3
        
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
}

// MARK: - ControlPanelView To ViewController
extension ViewController: ControlPanelViewDelegate {
    func controlPanelDidPressColorButton() {
        guard let shape = self.plane.currentItem as? BackgroundAdaptable else { return }
        
        let color = ColorFactory.makeTypeRandomly()

        shape.setBackgroundColor(color)
    }
    
    func controlPanelDidMoveAlphaSlider(_ sender: UISlider) {
        let value = sender.value.toFixed(digits: 1)
        
        guard let shape = self.plane.currentItem as? AlphaAdaptable else { return }
        guard let alpha = Alpha(rawValue: value) else { return }
        
        shape.setAlpha(alpha)
    }
}

// MARK: - RectangleView To ViewController
extension ViewController {
    @objc private func handleOnTapShapeView(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        let point = sender.location(in: self.planeView).convert(using: Point.self)
        
        guard let shape = self.plane.findItemBy(point: point) else { return }
        
        self.plane.selectItem(id: shape.id)
    }
}

// MARK: - Rectangle Model To ViewController
extension ViewController {
    private func createShapeView(ofClass Class: ShapeViewable.Type, with shape: Shape) {
        guard let shapeView = ShapeViewFactory.makeView(ofClass: Class, with: shape) else { return }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleOnTapShapeView))
        
        shapeView.addGestureRecognizer(tap)
        shapeView.animateScale(CGFloat(1.2), duration: 0.15, delay: 0)
        
        self.planeView.addSubview(shapeView)
        self.shapeMap.updateValue(shapeView, forKey: shape)
    }
    
    private func shapeModelDidChanged(_ notification: Notification) {
        guard let shape = self.plane.currentItem as? Shape else { return }
        guard let shapeView = self.shapeMap[shape] else { return }
        
        let color = notification.userInfo?[NotificationKey.updated] as? Color
        let alpha = notification.userInfo?[NotificationKey.updated] as? Alpha
        let alphaAdaptableShape = shape as? AlphaAdaptableShape
        let colorableShapeView = shapeView as? BackgroundViewable
        
        if let _ = alphaAdaptableShape, let alpha = alpha {
            shapeView.setAlpha(alpha)
        }

        if let shape = alphaAdaptableShape, let colorableShapeView = colorableShapeView, let color = color {
            colorableShapeView.setBackgroundColor(color: color, alpha: shape.alpha)
            self.controlPanelView.setColorButtonTitle(title: shapeView.backgroundColor?.toHexString() ?? "None")
        }
    }
}

// MARK: - Plane Model to ViewController
extension ViewController {
    private func planeDidSelectItem(_ notification: Notification) {
        guard let shape = notification.userInfo?[Plane.NotificationKey.select] as? Shape else { return }
        guard let shapeView = self.shapeMap[shape] else { return }
        
        shapeView.setBorder(width: 2, color: .blue)
        
        if let backgroundAdaptableShape = shape as? BackgroundAdaptable {
            let hexString = Color.toHexString(backgroundAdaptableShape.backgroundColor)
            self.controlPanelView.setColorButtonTitle(title: hexString)
        }
        
        if let AlphaAdaptableShape = shape as? AlphaAdaptable {
            self.controlPanelView.setAlphaSliderValue(value: AlphaAdaptableShape.alpha)
        }
        
        let isConformed = (shape as? ImageAdaptable) == nil
        
        self.controlPanelView.setColorButtonControllable(enable: isConformed)
        self.controlPanelView.setAlphaSliderControllable(enable: true)
    }
    
    private func planeDidUnselectItem(_ notification: Notification) {
        guard let shape = notification.userInfo?[Plane.NotificationKey.unselect] as? Shape else { return }
        guard let shapeView = self.shapeMap[shape] else { return }
        
        shapeView.removeBorder()
        
        self.controlPanelView.reset()
    }
}

// MARK: - PickerViewController to ViewController
extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.dismiss(animated: true)
        
        for result in results {
            let itemProvider = result.itemProvider
            
            guard itemProvider.canLoadObject(ofClass: UIImage.self) else { continue }
            
            itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                guard let url = url, error == nil else { return }
                
                let imageShape = RectangleFactory.makeRandomRectangle(with: url)
                
                self.plane.append(item: imageShape)
            }
        }
    }
}
