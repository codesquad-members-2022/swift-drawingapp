//
//  CanvasViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit

protocol LayerViewDraggable {
    func setDragHandler(handler: ((UIView) -> ())?)
}

class CanvasViewController: UIViewController,
                            UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate {
    
    private var plane = Plane()
    private var layerMap = [Layer: UIView]()
    private var viewMap = [UIView: Layer]()
    private let photoPicker = UIImagePickerController()
    private var temporaryView: UIView?
    private var canvasView: UIView?
    
    var didMoveTemporaryView: ((UIView) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribePlaneNotification()
        
        setCanvasView()
        setUpInitialModels()
        setUpTapRecognizer()
        
        photoPicker.delegate = self
        
        // Make other VC notify of User Interaction
        guard let primaryVC = splitViewController?.viewController(for: .primary) else { return }
        setHandler(to: primaryVC)
        
        guard let supplementaryVC = splitViewController?.viewController(for: .supplementary) else { return }
        setHandler(to: supplementaryVC)
    }
    
    private func setCanvasView() {
        let canvasView = UIView()
        self.canvasView = canvasView
        
        // CanvasView should be set behind of existing subviews
        view.insertSubview(canvasView, at: 0)
        
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setHandler(to viewController: UIViewController) {
        if let viewController = viewController as? LayerSelectable {
            setSelectHandler(to: viewController)
        }
        
        if let viewController = viewController as? LayerFetchable {
            setFetchHandler(to: viewController)
        }
        
        if let viewController = viewController as? LayerReoderable {
            setReorderHandler(to: viewController)
        }
        
        if let viewController = viewController as? LayerPropertyContollable {
            setControlHandler(to: viewController)
        }
    }
}

extension CanvasViewController: LayerViewDraggable {
    func setDragHandler(handler: ((UIView) -> ())?) {
        self.didMoveTemporaryView = handler
    }
}

// MARK: - Use case: Launch App

extension CanvasViewController {
    
    private func subscribePlaneNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didAddLayer(_:)), name: Plane.Event.didAddLayer, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectLayer(_:)), name: Plane.Event.didSelectLayer, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeColor(_:)), name: Plane.Event.didChangeColor, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeAlpha(_:)), name: Plane.Event.didChangeAlpha, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrigin(_:)), name: Plane.Event.didChangeOrigin, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSize(_:)), name: Plane.Event.didChangeSize, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeText(_:)), name: Plane.Event.didChangeText, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didReorderLayer(_:)), name: Plane.Event.didReorderLayer, object: nil)
        
    }
    
    private func setUpInitialModels() {
        (0..<4).forEach { _ in plane.add(type: Rectangle.self) }
    }
    
    private func setUpTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        canvasView?.addGestureRecognizer(tap)
    }
}

// MARK: - Use Case: Touch Rectangle button (Input) & Add New Rectangle (Output)

extension CanvasViewController {
    
    @IBAction func didTouchRectangleButton(_ sender: UIButton) {
        plane.add(type: Rectangle.self)
    }
    
    @objc func didAddLayer(_ notification: Notification) {
        guard let newLayer = notification.userInfo?[Plane.InfoKey.added] as? Layer else { return }
        guard let newView = ViewFactory.create(from: newLayer) else { return }
        
        map(newView, to: newLayer)
        
        if newView is UILabel { resizeToFit(newLayer, for: newView) }
        
        canvasView?.addSubview(newView)
        setupPanRecognizer(newView)
    }
    
    private func createView(from layer: Layer) -> UIView? {
        return ViewFactory.create(from: layer)
    }
    
    private func map(_ view: UIView, to layer: Layer) {
        layerMap[layer] = view
        viewMap[view] = layer
    }
}

// MARK: - Use Case: Touch Photo button (Input) & Add New Photo (Output)

extension CanvasViewController {
    
    @IBAction func didTouchPhotoButton(_ sender: UIButton) {
        present(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage,
              let imageData = image.pngData() else { return }
        
        plane.add(type: Photo.self, data: imageData)
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Use Case: Touch label button (Input) & Add New Label (Output)

extension CanvasViewController {
    @IBAction func didTouchLabelButton(_ sender: UIButton) {
        plane.add(type: Label.self)
    }
    
    // Set Layer to fit intrinsic content size
    private func resizeToFit(_ layer: Layer, for view: UIView) {
        let fitSize = Size(width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        plane.change(layer: layer, toSize: fitSize)
    }
}

// MARK: - Use Case: Tap CanvasView (Input) & Select Layer (Output)

extension CanvasViewController {
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: canvasView)
        let tappedPoint = Point(x: location.x, y: location.y)
        plane.tap(on: tappedPoint)
    }
    
    @objc func didSelectLayer(_ notification: Notification) {
        if let new = notification.userInfo?[Plane.InfoKey.selected] as? Layer {
            guard let newView = search(for: new) else { return }
            changeBorder(newView)
        }
        
        if let old = notification.userInfo?[Plane.InfoKey.unselected] as? Layer {
            guard let oldView = search(for: old) else { return }
            clearBorder(oldView)
        }
    }
    
    private func search(for layer: Layer) -> UIView? {
        return layerMap[layer]
    }
    
    private func changeBorder(_ view: UIView) {
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func clearBorder(_ view: UIView) {
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.clear.cgColor
    }
}

// MARK: - Use Case: Control property of selected layer (Input)

extension CanvasViewController {
    
    private func setControlHandler(to layerPropertyContollable: LayerPropertyContollable) {
        
        layerPropertyContollable.setColorButtonHandler { [weak self] color in
            self?.plane.changeSelected(toColor: color)
        }
        
        layerPropertyContollable.setSizeStepperHandler { [weak self] size in
            self?.plane.changeSelected(toSize: size)
        }
        
        layerPropertyContollable.setOriginStepperHandler { [weak self] origin in
            self?.plane.changeSelected(toOrigin: origin)
        }
        
        layerPropertyContollable.setSliderHandler { [weak self] value in
            guard let alpha = Alpha(value) else { return }
            self?.plane.changeSelected(toAlpha: alpha)
        }
        
        layerPropertyContollable.setTextFieldHandler {
            [weak self] text in
                self?.plane.changeSelected(toText: text)
        }
    }
}

// MARK: - Use Case: Change Color (Output)

extension CanvasViewController {
    
    @objc func didChangeColor(_ notification: Notification) {
        guard let selected = plane.selected,
              let newColor = notification.userInfo?[Plane.InfoKey.changed] as? Color else { return }
        let mutatedUIView = search(for: selected)
        mutatedUIView?.backgroundColor = UIColor(with: newColor)
    }
}

// MARK: - Use Case: Change Alpha (Output)

extension CanvasViewController {
    
    @objc func didChangeAlpha(_ notification: Notification) {
        guard let selected = plane.selected,
              let newAlpha = notification.userInfo?[Plane.InfoKey.changed] as? Alpha else { return }
        let mutatedUIView = search(for: selected)
        mutatedUIView?.alpha = CGFloat(with: newAlpha)
    }
}

// MARK: - Use Case: Change origin (Output)

extension CanvasViewController {
    
    @objc func didChangeOrigin(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.changed] as? Layer else { return }
        let mutatedCavnasView = search(for: mutated)
        mutatedCavnasView?.frame.origin = CGPoint(with: mutated.origin)
    }
}

// MARK: - Use Case: Change size (Output)

extension CanvasViewController {
    
    @objc func didChangeSize(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.changed] as? Layer else { return }
        let mutatedUIView = search(for: mutated)
        mutatedUIView?.frame.size = CGSize(with: mutated.size)
    }
}

// MARK: - Use Case: Change text (Output)

extension CanvasViewController {
    
    @objc func didChangeText(_ notification: Notification) {
        guard let selected = plane.selected,
              let mutatedUIView = search(for: selected) as? UILabel,
              let newText = notification.userInfo?[Plane.InfoKey.changed] as? String else { return }
        mutatedUIView.text = newText
        resizeToFit(selected, for: mutatedUIView)
    }
}

// MARK: - Use Case: Drag layer (Input) & Change origin (Output)

extension CanvasViewController {
    
    private func setupPanRecognizer(_ canvasView: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
        canvasView.isUserInteractionEnabled = true
        canvasView.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        startPan(gesture)
        drag(gesture)
        endPan(gesture)
    }
    
    private func startPan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view,
              gesture.state == .began else { return }
        
        guard let temporaryView = gestureView.copy() as? UIView else { return }
        
        self.temporaryView = temporaryView
        canvasView?.addSubview(temporaryView)
    }
    
    private func drag(_ gesture: UIPanGestureRecognizer) {
        guard let temporaryView = temporaryView else { return }
        
        let translation = gesture.translation(in: view)
        temporaryView.center = CGPoint(
            x: temporaryView.center.x + translation.x,
            y: temporaryView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
        didMoveTemporaryView?(temporaryView)
    }

    private func endPan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view,
              let gestureLayer = viewMap[gestureView],
              let temporaryView = temporaryView,
              gesture.state == .ended else { return }
        
        let lastOrigin = Point(x: temporaryView.frame.origin.x,
                               y: temporaryView.frame.origin.y)
        
        plane.change(layer: gestureLayer, toOrigin: lastOrigin)
        temporaryView.removeFromSuperview()
    }
    
    private func search(for view: UIView) -> Layer? {
        return viewMap[view]
    }
}

// MARK: - Use Case: Reorder Layers via tableView cell (Input) & Reorder LayerViews in view hierachy (Ouput)

extension CanvasViewController {
    
    func setReorderHandler(to layerReorderable: LayerReoderable) {
        
        layerReorderable.setReorderHandler { [weak self] from, to in
            self?.plane.reorderLayer(fromIndex: from, toIndex: to)
        }
        
        layerReorderable.setReorderCommandHandler { [weak self] layer, command in
            self?.plane.reorderLayer(layer, to: command)
        }
    }
    
    @objc func didReorderLayer(_ notification: Notification) {
        guard let reorderedLayer = notification.userInfo?[Plane.InfoKey.changed] as? Layer,
              let layerView = layerMap[reorderedLayer],
              let to = notification.userInfo?[Plane.InfoKey.toIndex] as? Int else {
                  return
              }
        canvasView?.insertSubview(layerView, at: to)
    }
}

// MARK: - Use Case: Select Layer via tableView cell (Input)

extension CanvasViewController {
    
    private func setSelectHandler(to layerSelectable: LayerSelectable) {
        layerSelectable.setSelectHandler { [weak self] selected in
            self?.plane.select(layer: selected)
        }
    }
}


extension CanvasViewController {
    
    private func setFetchHandler(to layerFetchable: LayerFetchable) {
        layerFetchable.setFetchLayerHandler {  [weak self] index in
            return self?.plane[index]
        }
        
        layerFetchable.setFetchLayerCountHandler { [weak self] in
            return self?.plane.layerCount
        }
    }
}
