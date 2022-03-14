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
        topMenuBarView.translatesAutoresizingMaskIntoConstraints = false
        topMenuBarView.backgroundColor = UIColor(red: 245 / 255.0, green: 1, blue: 250 / 255.0, alpha: 1)
        topMenuBarView.layer.cornerRadius = 5
        topMenuBarView.layer.borderColor = UIColor.black.cgColor
        topMenuBarView.layer.borderWidth = 1
        return topMenuBarView
    }()
    
    let inspectorView: InspectorView = {
        let inspectorView = InspectorView()
        inspectorView.backgroundColor = UIColor(red: 245 / 255.0, green: 1, blue: 250 / 255.0, alpha: 1)
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        return inspectorView
    }()
    
    let hierarchyView: HierarchyView = {
        let hierarchyView = HierarchyView()
        hierarchyView.translatesAutoresizingMaskIntoConstraints = false
        hierarchyView.backgroundColor = UIColor(red: 245 / 255.0, green: 1, blue: 250 / 255.0, alpha: 1)
        return hierarchyView
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
        hierarchyView.delegate = self
        plane.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGusture))
        self.drawingBoard.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGusture))
        self.drawingBoard.addGestureRecognizer(panGesture)
    }
    
    func bind() {
        NotificationCenter.default.addObserver(forName: Plane.Event.didMakeDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
                return
            }
            DispatchQueue.main.async {
                let drawView = DrawingViewFactory.make(model: model)
                self.drawingBoard.addSubview(drawView)
                self.drawingViews[model] = drawView
                self.hierarchyView.updateView()
            }
            self.bindObserver(targetModel: model)
        }
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didSelecteDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
                    let index = notification.userInfo?[Plane.ParamKey.index] as? Int else {
                return
            }
            self.inspectorView.setHidden(false)
            self.inspectorView.update(model: model)
            self.hierarchyView.selectIndex(index)
            self.drawingViews[model]?.selected(is: true)
        }
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didDeselecteDrawingModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
                  let index = notification.userInfo?[Plane.ParamKey.index] as? Int else {
                return
            }
            self.inspectorView.setHidden(true)
            self.hierarchyView.deSelecteIndex(index)
            self.drawingViews[model]?.selected(is: false)
        }
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didMoveModel, object: nil, queue: nil) { notification in
            guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
                  let index = notification.userInfo?[Plane.ParamKey.index] as? Int,
                  let targetView = self.drawingViews[model] else {
                return
            }
            self.drawingBoard.insertSubview(targetView, at: index)
            self.hierarchyView.updateView()
        }
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didBeganDrag, object: nil, queue: nil) { notification in
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
                
        NotificationCenter.default.addObserver(forName: Plane.Event.didChangedDrag, object: nil, queue: nil) { notification in
            guard let point = notification.userInfo?[Plane.ParamKey.dragPoint] as? Point,
                  let dummyView = self.dummyView else {
                return
            }
            dummyView.isHidden = false
            dummyView.frame.origin = CGPoint(x: point.x, y: point.y)
            self.inspectorView.update(origin: Point(x: point.x, y: point.y))
        }
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didEndedDrag, object: nil, queue: nil) { notification in
            self.dummyView?.removeFromSuperview()
            self.dummyView = nil
        }
    }
    
    func bindObserver(targetModel: DrawingModel) {
        NotificationCenter.default.addObserver(forName: DrawingModel.Event.updateColor, object: targetModel, queue: nil) { notification in
            guard let view = self.drawingViews[targetModel] as? Colorable,
                  let color = notification.userInfo?[DrawingModel.ParamKey.color] as? Color else {
                return
            }
            view.update(color: color)
            self.inspectorView.update(color: color)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.Event.updateAlpha, object: targetModel, queue: nil) { notification in
            guard let alpha = notification.userInfo?[DrawingModel.ParamKey.alpha] as? Alpha else {
                return
            }
            self.drawingViews[targetModel]?.update(alpha: alpha)
            self.inspectorView.update(alpha: alpha)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.Event.updateOrigin, object: targetModel, queue: nil) { notification in
            guard let origin = notification.userInfo?[DrawingModel.ParamKey.origin] as? Point else {
                return
            }
            self.drawingViews[targetModel]?.update(origin: origin)
            self.inspectorView.update(origin: origin)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.Event.updateSize, object: targetModel, queue: nil) { notification in
            guard let size = notification.userInfo?[DrawingModel.ParamKey.size] as? Size else {
                return
            }
            self.drawingViews[targetModel]?.update(size: size)
            self.inspectorView.update(size: size)
        }
        
        NotificationCenter.default.addObserver(forName: DrawingModel.Event.updateFont, object: targetModel, queue: nil) { notification in
            guard let view = self.drawingViews[targetModel] as? Textable,
                let font = notification.userInfo?[DrawingModel.ParamKey.font] as? Font else {
                return
            }
            view.update(font: font)
            self.inspectorView.update(font: font)
        }
    }
    
    func layout() {
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(drawingBoard)
        self.view.addSubview(inspectorView)
        self.view.addSubview(topMenuBarView)
        self.view.addSubview(hierarchyView)
        
        drawingBoard.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        drawingBoard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        drawingBoard.leftAnchor.constraint(equalTo: self.hierarchyView.rightAnchor).isActive = true
        drawingBoard.rightAnchor.constraint(equalTo: inspectorView.leftAnchor).isActive = true
        
        inspectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        inspectorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        inspectorView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        inspectorView.widthAnchor.constraint(equalTo: safeAreaGuide.widthAnchor, multiplier: 0.15).isActive = true
        
        topMenuBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topMenuBarView.centerXAnchor.constraint(equalTo: self.drawingBoard.centerXAnchor).isActive = true
        topMenuBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        hierarchyView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        hierarchyView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        hierarchyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        hierarchyView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    
    @objc private func tapGusture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.plane.tapGusturePoint(Point(x: location.x, y: location.y))
    }
    
    @objc private func panGusture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        let point = Point(x: location.x, y: location.y)
        switch sender.state {
        case .began:
            self.plane.beganDragPoint(point)
        case .changed:
            self.plane.changedDragPoint(point)
        case .ended:
            self.plane.endedDragPoint(point)
        default:
            break
        }
    }
}

extension ViewController: HierarchyDelegate {
    func getCount() -> Int {
        self.plane.count
    }
    
    func getModel(to: IndexPath) -> DrawingModel? {
        guard let model = self.plane[to.row] else {
            return nil
        }
        return model
    }
    
    func getSelectIndex() -> Int? {
        self.plane.selectIndex
    }
    
    func selectedCell(index: IndexPath) {
        self.plane.selecteModel(index: index.row)
    }
    
    func move(to: Plane.MoveTo) {
        self.plane.move(to: to)
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
    func changeFont(name: String) {
        self.plane.change(fontName: name)
    }
    
    func changeColor() {
        self.plane.change(color: Color(using: RandomColorGenerator()))
    }
    
    func changeAlpha(_ alpha: Alpha) {
        self.plane.change(alpha: alpha)
    }
    
    func transform(translationX: Double, y: Double) {
        self.plane.transform(translationX:translationX, y: y)
    }
    
    func transform(width: Double, height: Double) {
        self.plane.transform(width: width, height: height)
    }
}

extension ViewController: TopMenuBarDelegate {
    func makeRectangleTapped() {
        let screenSize = self.drawingBoard.frame.size
        let originX = Int.random(in: 0..<Int(screenSize.width))
        let originY = Int.random(in: 0..<Int(screenSize.height))
        self.plane.makeRectangleModel(origin: Point(x: originX, y: originY))
    }
    
    func makePhotoTapped() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .any(of: [.images])
        let phpPicker = PHPickerViewController(configuration: config)
        phpPicker.delegate = self
        self.present(phpPicker, animated: true)
    }
    
    func makeLabelTapped() {
        let screenSize = self.drawingBoard.frame.size
        let originX = Int.random(in: 0..<Int(screenSize.width))
        let originY = Int.random(in: 0..<Int(screenSize.height))
        self.plane.makeLabelModel(origin: Point(x: originX, y: originY))
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
