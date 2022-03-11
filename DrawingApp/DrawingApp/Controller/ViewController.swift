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
    private var plane = Plane()
    private var rectangleMap = [Rectangle: RectangleView]()
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.rectangleDataDidCreated), name: .RectangleDataDidCreated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.rectangleDataDidChanged), name: .RectangleDataDidUpdated, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.planeDidDidSelectItem), name: .PlaneDidSelectItem, object: self.plane)
        NotificationCenter.default.addObserver(self, selector: #selector(self.planeDidDidUnselectItem), name: .PlaneDidUnselectItem, object: self.plane)
    }
}

// MARK: - PlaneView To ViewController
extension ViewController: PlaneViewDelegate {
    func planeViewDidTapped(_ sender: UITapGestureRecognizer) {
        self.plane.unselectItem()
    }
    
    func planeViewDidPressRectangleAddButton() {
        let rectangle = RectangleFactory.makeRandomRectangle()
        plane.append(item: rectangle)
    }
    
    func planeViewDidPressImageAddButton() {
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
        guard let rectangle = self.plane.currentItem else { return }
        guard let color = UIColor.random().convert(using: Color.self, multiplier: 255) else { return }
        
        rectangle.setBackgroundColor(color)
    }
    
    func controlPanelDidMoveAlphaSlider(_ sender: UISlider) {
        guard let rectangle = self.plane.currentItem else { return }
        guard let alpha = Alpha(rawValue: Int(sender.value)) else { return }
        
        rectangle.setAlpha(alpha)
    }
}

// MARK: - RectangleView To ViewController
extension ViewController {
    @objc private func handleOnTapRectangleView(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        
        let point = sender.location(in: self.planeView).convert(using: Point.self)
        
        guard let rectangle = self.plane.findItemBy(point: point) else { return }
        
        self.plane.selectItem(id: rectangle.id)
    }
}

// MARK: - Rectangle Model To ViewController
extension ViewController {
    @objc private func rectangleDataDidCreated(_ notification: Notification) {
        guard let rectangle = notification.object as? Rectangle else { return }
        
        let rectangleView = RectangleView(with: rectangle)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleOnTapRectangleView))
        
        rectangleView.addGestureRecognizer(tap)
        rectangleView.accessibilityIdentifier = rectangle.id
        
        self.planeView.addSubview(rectangleView)
        self.rectangleMap.updateValue(rectangleView, forKey: rectangle)
        rectangleView.animateScale(CGFloat(1.2), duration: 0.15, delay: 0)
    }
    
    
    @objc private func rectangleDataDidChanged(_ notification: Notification) {
        guard let rectangle = self.plane.currentItem else { return }
        guard let rectangleView = self.rectangleMap[rectangle] else { return }
        
        if let alpha = notification.userInfo?[Rectangle.NotificationKey.alpha] as? Alpha {
            rectangleView.setBackgroundColor(with: alpha)
        }
        
        if let color = notification.userInfo?[Rectangle.NotificationKey.color] as? Color {
            rectangleView.setBackgroundColor(color: color, alpha: rectangle.alpha)
            self.controlPanelView.setColorButtonTitle(title: UIColor(with: color).toHexString())
        }
    }
}

// MARK: - Plane Model to ViewController
extension ViewController {
    @objc private func planeDidDidSelectItem(_ notification: Notification) {
        guard let rectangle = notification.userInfo?[Plane.NotificationKey.select] as? Rectangle else { return }
        guard let rectangleView = self.rectangleMap[rectangle] else { return }
        let hexString = UIColor(with: rectangle.backgroundColor).toHexString()
        
        rectangleView.setBorder(width: 2, color: .blue)
        
        self.controlPanelView.setColorButtonTitle(title: hexString)
        self.controlPanelView.setAlphaSliderValue(value: rectangle.alpha)
    }
    
    @objc private func planeDidDidUnselectItem(_ notification: Notification) {
        guard let rectangle = notification.userInfo?[Plane.NotificationKey.unselect] as? Rectangle else { return }
        guard let rectangleView = self.rectangleMap[rectangle] else { return }
        
        rectangleView.removeBorder()
    }
}

// MARK: - PickerViewController to ViewController
extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.dismiss(animated: true)
        
        let group = DispatchGroup()
        var images = [UIImage]()
        
        for result in results {
            let itemProvider = result.itemProvider
            
            guard itemProvider.canLoadObject(ofClass: UIImage.self) else { continue }
            
            group.enter()
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                defer {
                    group.leave()
                }
                
                guard let image = image as? UIImage, error == nil else { return }
                images.append(image)
            }
        }
        
        group.notify(queue: DispatchQueue.global()) {
            // TODO: 이미지 모델 생성
            for image in images {
                
            }
        }
    }
}
