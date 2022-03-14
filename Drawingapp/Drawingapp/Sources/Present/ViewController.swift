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
    }
    
    func bind() {
        topMenuBind()
        inspectorBind()
        gustureBind()
        hierarchyBind()
        plane.delegate = self
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

extension ViewController: PlaneDelegate {
    func getDrawingModelFactory() -> DrawingModelFactory {
        DrawingModelFactory(colorFactory: ColorFactory())
    }
    
    func getScreenSize() -> Size {
        Size(width: self.drawingBoard.frame.width, height: self.drawingBoard.frame.height)
    }
}

//MARK: Common
extension ViewController {
    private func didSelecteDrawingModel(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
                let index = notification.userInfo?[Plane.ParamKey.index] as? Int else {
            return
        }
        self.inspectorView.setHidden(false)
        self.inspectorView.update(model: model)
        self.hierarchyView.selectIndex(index)
        self.drawingViews[model]?.selected(is: true)
    }
    
    private func didDeselecteDrawingModel(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
              let index = notification.userInfo?[Plane.ParamKey.index] as? Int else {
            return
        }
        self.inspectorView.setHidden(true)
        self.hierarchyView.deSelecteIndex(index)
        self.drawingViews[model]?.selected(is: false)
    }
}

//MARK: Gusture
extension ViewController {
    func gustureBind() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGusture))
        self.drawingBoard.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGusture))
        self.drawingBoard.addGestureRecognizer(panGesture)
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didBeganDrag, object: nil, queue: nil, using: didBeganDrag)
                
        NotificationCenter.default.addObserver(forName: Plane.Event.didChangedDrag, object: nil, queue: nil, using: didChangedDrag)
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didEndedDrag, object: nil, queue: nil, using: didEndedDrag)
    }
    
    //MARK: Input
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
    
    //MARK: Output
    private func didBeganDrag(notification: Notification) {
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
    
    private func didChangedDrag(notification: Notification) {
        guard let point = notification.userInfo?[Plane.ParamKey.dragPoint] as? Point,
              let dummyView = self.dummyView else {
            return
        }
        dummyView.isHidden = false
        dummyView.frame.origin = CGPoint(x: point.x, y: point.y)
        self.inspectorView.update(origin: Point(x: point.x, y: point.y))
    }
    
    private func didEndedDrag(notification: Notification) {
        self.dummyView?.removeFromSuperview()
        self.dummyView = nil
    }
}

//MARK: Hierarchy
extension ViewController: HierarchyDelegate {
    func hierarchyBind() {
        hierarchyView.delegate = self
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didMoveModel, object: nil, queue: nil, using: didMoveModel)
    }
    
    //MARK: inject
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
    
    //MARK: Input
    func selectedCell(index: IndexPath) {
        self.plane.selecteModel(index: index.row)
    }
    
    func move(to: Plane.MoveTo) {
        self.plane.move(to: to)
    }
    
    //MARK: Output
    private func didMoveModel(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
              let index = notification.userInfo?[Plane.ParamKey.index] as? Int,
              let targetView = self.drawingViews[model] else {
            return
        }
        self.drawingBoard.insertSubview(targetView, at: index)
        self.hierarchyView.updateView()
    }
}

//MARK: Inspector
extension ViewController: InspectorDelegate {
    func inspectorBind() {
        inspectorView.delegate = self
        NotificationCenter.default.addObserver(forName: Plane.Event.didUpdateColor, object: nil, queue: nil, using: didUpdateColor)
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didUpdateAlpha, object: nil, queue: nil, using: didUpdateAlpha)
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didUpdateOrigin, object: nil, queue: nil, using: didUpdateOrigin)
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didUpdateSize, object: nil, queue: nil, using: didUpdateSize)
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didUpdateFont, object: nil, queue: nil, using: didUpdateFont)
    }
    
    //MARK: Input
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
    
    //MARK: Output
    func didUpdateColor(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
              let colableView = self.drawingViews[model] as? Colorable,
              let color = notification.userInfo?[Plane.ParamKey.color] as? Color else {
            return
        }
        colableView.update(color: color)
        self.inspectorView.update(color: color)
    }
    
    func didUpdateAlpha(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
              let alpha = notification.userInfo?[Plane.ParamKey.alpha] as? Alpha else {
            return
        }
        self.drawingViews[model]?.update(alpha: alpha)
        self.inspectorView.update(alpha: alpha)
    }
    
    func didUpdateOrigin(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
              let origin = notification.userInfo?[Plane.ParamKey.origin] as? Point else {
            return
        }
        self.drawingViews[model]?.update(origin: origin)
        self.inspectorView.update(origin: origin)
    }
    
    func didUpdateSize(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
              let size = notification.userInfo?[Plane.ParamKey.size] as? Size else {
            return
        }
        self.drawingViews[model]?.update(size: size)
        self.inspectorView.update(size: size)
    }
    
    func didUpdateFont(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel,
              let textable = self.drawingViews[model] as? Textable,
            let font = notification.userInfo?[Plane.ParamKey.font] as? Font else {
            return
        }
        textable.update(font: font)
        self.inspectorView.update(font: font)
    }
}

//MARK: TopMenu
extension ViewController: TopMenuBarDelegate, PHPickerViewControllerDelegate {
    private func topMenuBind() {
        topMenuBarView.delegate = self
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didMakeDrawingModel, object: nil, queue: nil, using: didMakeDrawingModel)
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didSelecteDrawingModel, object: nil, queue: nil, using: didSelecteDrawingModel)
        
        NotificationCenter.default.addObserver(forName: Plane.Event.didDeselecteDrawingModel, object: nil, queue: nil, using: didDeselecteDrawingModel)
    }
    
    //MARK: Input
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
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider else {
            return
        }
        
        itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
            guard let url = url else { return }
            
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
    
    //MARK: Output
    private func didMakeDrawingModel(notification: Notification) {
        guard let model = notification.userInfo?[Plane.ParamKey.drawingModel] as? DrawingModel else {
            return
        }
        
        DispatchQueue.main.async {
            let drawView = DrawingViewFactory.make(model: model)
            self.drawingBoard.addSubview(drawView)
            self.drawingViews[model] = drawView
            self.hierarchyView.updateView()
        }
    }
}
