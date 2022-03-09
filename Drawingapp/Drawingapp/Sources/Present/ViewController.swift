//
//  ViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    let drawingBoard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topMenuBarView: TopMenuBarView = {
        let topMenuBarView = TopMenuBarView()
        topMenuBarView.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        topMenuBarView.layer.cornerRadius = 5
        topMenuBarView.translatesAutoresizingMaskIntoConstraints = false
        return topMenuBarView
    }()
    
    let inspectorView: InspectorView = {
        let inspectorView = InspectorView()
        inspectorView.isHidden = true
        inspectorView.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        return inspectorView
    }()
    
    let plane = Plane(drawingModelFactory: DrawingModelFactory(sizeFactory: SizeFactory(), pointFactory: PointFactory(), colorFactory: ColorFactory()))
    var drawingViews: [DrawingModel:DrawingView] = [:]
    var dummyView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        layout()
        
        inspectorView.delegate = self
        topMenuBarView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGusture))
        tapGesture.delegate = self
        self.drawingBoard.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGusture))
        panGesture.delegate = self
        panGesture.require(toFail: tapGesture)
        self.drawingBoard.addGestureRecognizer(panGesture)
    }
    
    func bind() {
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didDisSelectedDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                return
            }
            self.inspectorView.isHidden = true
            self.drawingViews[model]?.selected(is: false)
        }
        
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didSelectedDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                return
            }
            self.inspectorView.isHidden = false
            self.inspectorView.update(model: model)
            self.drawingViews[model]?.selected(is: true)
        }
                
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didMakeDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                return
            }
            DispatchQueue.main.async {
                let drawView = DrawingViewFactory.make(model: model)
                self.drawingBoard.addSubview(drawView)
                self.drawingViews[model] = drawView
            }
        }
        
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.makeDragDummyView, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
                  let selectView = self.drawingViews[model],
                  let copyView = selectView.copy() as? UIView else {
                return
            }
            
            self.drawingBoard.addSubview(copyView)
            copyView.alpha = 0.5
            copyView.isHidden = true
            self.dummyView = copyView
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.NotifiName.updateColor, object: nil, queue: nil) { notification in
            guard let model = notification.object as? DrawingModel,
                  let view = self.drawingViews[model] as? Colorable,
                  let color = notification.userInfo?[DrawingModel.ParamKey.color] as? Color else {
                return
            }
            view.update(color: color)
            self.inspectorView.update(color: color)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.NotifiName.updateAlpha, object: nil, queue: nil) { notification in
            guard let model = notification.object as? DrawingModel,
                  let alpha = notification.userInfo?[DrawingModel.ParamKey.alpha] as? Alpha else {
                return
            }
            self.drawingViews[model]?.update(alpha: alpha)
            self.inspectorView.update(alpha: alpha)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.NotifiName.updatePoint, object: nil, queue: nil) { notification in
            guard let model = notification.object as? DrawingModel,
                  let point = notification.userInfo?[DrawingModel.ParamKey.point] as? Point else {
                return
            }
            self.drawingViews[model]?.update(point: point)
        }
    }
    
    func layout() {
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(drawingBoard)
        self.view.addSubview(inspectorView)
        self.view.addSubview(topMenuBarView)
        
        drawingBoard.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        drawingBoard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        drawingBoard.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        drawingBoard.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        inspectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        inspectorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        inspectorView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        inspectorView.widthAnchor.constraint(equalTo: safeAreaGuide.widthAnchor, multiplier: 0.25).isActive = true
        
        topMenuBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topMenuBarView.centerXAnchor.constraint(equalTo: self.drawingBoard.centerXAnchor).isActive = true
        topMenuBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let pangesture = gestureRecognizer as? UIPanGestureRecognizer {
            let location = pangesture.location(in: pangesture.view)
            self.plane.touchPoint(where: Point(x: location.x, y: location.y))
        }
        return true
    }
    
    @objc private func tapGusture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.plane.touchPoint(where: Point(x: location.x, y: location.y))
    }
    
    @objc private func panGusture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        
        switch sender.state {
        case .began:
            self.plane.beganDrag()
        case .changed:
            guard let dummyView = self.dummyView else {
                return
            }
            let size = dummyView.frame.size
            dummyView.isHidden = false
            dummyView.frame.origin = CGPoint(x: location.x - size.width / 2 , y: location.y - size.height / 2)
        case .ended:
            self.dummyView?.removeFromSuperview()
            self.dummyView = nil
            self.plane.pointChanged(where: Point(x: location.x, y: location.y))
        default:
            break
        }
    }
}

extension ViewController: InspectorDelegate {
    func usingColorFactory() -> ColorFactory {
        ColorFactory()
    }
    
    func changeColorButtonTapped() {
        self.plane.colorChanged()
    }
    
    func alphaSliderValueChanged(alpha: Alpha) {
        self.plane.alphaChanged(alpha)
    }
}

extension ViewController: TopMenuBarDelegate {
    func makeRectangleButtonTapped() {
        self.plane.makeRectangleModel()
    }
    
    func makePhotoButtonTapped() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .any(of: [.images])
        let phpPicker = PHPickerViewController(configuration: config)
        phpPicker.delegate = self
        self.present(phpPicker, animated: true)
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider else {
            return
        }
        
        itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
            guard let url = url else {
                return
            }
            
            let fileManager = FileManager.default
            let destination = fileManager.temporaryDirectory.appendingPathComponent(url.lastPathComponent)
            do {
                if fileManager.fileExists(atPath: destination.path) {
                    try? fileManager.removeItem(at: destination)
                }
                try? fileManager.copyItem(at: url, to: destination)
                self.plane.makePhotoModel(url: destination)
            } catch {
                Log.error("image Load Fail: \(url)")
            }
        }
    }
}
