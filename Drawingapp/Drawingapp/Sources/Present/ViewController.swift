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
    
    let plane = Plane()
    var drawingViews: [DrawingModel:DrawingView] = [:]
    var dummyView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        layout()
        
        inspectorView.delegate = self
        topMenuBarView.delegate = self
        plane.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGusture))
        self.drawingBoard.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGusture))
        self.drawingBoard.addGestureRecognizer(panGesture)
    }
    
    func bind() {
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didMakeDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                return
            }
            DispatchQueue.main.async {
                let drawView = DrawingViewFactory.make(model: model)
                self.drawingBoard.addSubview(drawView)
                self.drawingViews[model] = drawView
            }
            self.bindObserver(targetModel: model)
        }
        
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didSelectedDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                return
            }
            self.inspectorView.isHidden = false
            self.inspectorView.update(model: model)
            self.drawingViews[model]?.selected(is: true)
        }
        
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didDisSelectedDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                return
            }
            self.inspectorView.isHidden = true
            self.drawingViews[model]?.selected(is: false)
        }
        
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didBeganDrag, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
                  let selectView = self.drawingViews[model],
                  let snapshotView = selectView.snapshotView() else {
                return
            }
            
            self.drawingBoard.addSubview(snapshotView)
            snapshotView.alpha = 0.5
            snapshotView.isHidden = true
            self.dummyView = snapshotView
        }
                
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didChangedDrag, object: nil, queue: nil) { notification in
            guard let point = notification.userInfo?[Plane.ParamKey.dragPoint] as? Point,
                  let dummyView = self.dummyView else {
                return
            }
            dummyView.isHidden = false
            dummyView.frame.origin = CGPoint(x: point.x, y: point.y)
            self.inspectorView.update(origin: Point(x: point.x, y: point.y))
        }
        
        NotificationCenter.default.addObserver(forName: Plane.NotifiName.didEndedDrag, object: nil, queue: nil) { notification in
            self.dummyView?.removeFromSuperview()
            self.dummyView = nil
            
        }
    }
    
    func bindObserver(targetModel: DrawingModel) {
        NotificationCenter.default.addObserver(forName: DrawingModel.NotifiName.updateColor, object: targetModel, queue: nil) { notification in
            guard let view = self.drawingViews[targetModel] as? Colorable,
                  let color = notification.userInfo?[DrawingModel.ParamKey.color] as? Color else {
                return
            }
            view.update(color: color)
            self.inspectorView.update(color: color)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.NotifiName.updateAlpha, object: targetModel, queue: nil) { notification in
            guard let alpha = notification.userInfo?[DrawingModel.ParamKey.alpha] as? Alpha else {
                return
            }
            self.drawingViews[targetModel]?.update(alpha: alpha)
            self.inspectorView.update(alpha: alpha)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.NotifiName.updatePoint, object: targetModel, queue: nil) { notification in
            guard let origin = notification.userInfo?[DrawingModel.ParamKey.origin] as? Point else {
                return
            }
            self.drawingViews[targetModel]?.update(origin: origin)
            self.inspectorView.update(origin: origin)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.NotifiName.updateSize, object: targetModel, queue: nil) { notification in
            guard let size = notification.userInfo?[DrawingModel.ParamKey.size] as? Size else {
                return
            }
            self.drawingViews[targetModel]?.update(size: size)
            self.inspectorView.update(size: size)
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
    
    @objc private func tapGusture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.plane.touchPoint(Point(x: location.x, y: location.y))
    }
    
    @objc private func panGusture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.plane.onPanGustureAction(state: sender.state, point: Point(x: location.x, y: location.y))
    }
}

extension ViewController: PlaneDelegate {
    func getDrawingModelFactory() -> DrawingModelFactory {
        DrawingModelFactory(colorFactory: ColorFactory())
    }
    
    func getScreenSize() -> Size {
        Size(width: self.drawingBoard.frame.width, height: self.drawingBoard.frame.height)
    }
}

extension ViewController: InspectorDelegate {
    func colorChanged() {
        self.plane.colorChanged()
    }
    
    func alphaChanged(_ alpha: Alpha) {
        self.plane.alphaChanged(alpha)
    }
    
    func originMoved(x: Double, y: Double) {
        self.plane.originMoved(x:x, y: y)
    }
    
    func sizeIncrease(width: Double, height: Double) {
        self.plane.sizeIncrease(width: width, height: height)
    }
}

extension ViewController: TopMenuBarDelegate {
    func makeRectangleButtonTapped() {
        let screenSize = UIScreen.main.bounds.size
        let originX = Int.random(in: 0..<Int(screenSize.width))
        let originY = Int.random(in: 0..<Int(screenSize.height))
        self.plane.makeRectangleModel(origin: Point(x: originX, y: originY))
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
                
                let screenSize = UIScreen.main.bounds.size
                let originX = Int.random(in: 0..<Int(screenSize.width))
                let originY = Int.random(in: 0..<Int(screenSize.height))
                self.plane.makePhotoModel(origin: Point(x: originX, y: originY), url: destination)
            } catch {
                Log.error("image Load Fail: \(url)")
            }
        }
    }
}
