//
//  CanvasViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit

class CanvasViewController: UIViewController,
                            UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate {
    
    private var plane = Plane()
    private var layerMap = [Layer: UIView]()
    private var viewMap = [UIView: Layer]()
    private let photoPicker = UIImagePickerController()
    private var temporaryView: UIView?
    
    enum Event {
        static let isDragging = Notification.Name("drag")
    }
    
    enum InfoKey {
        static let origin = "origin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observePlane()
        observePanel()
        
        setUpInitialModels()
        setUpTapRecognizer()
        
        photoPicker.delegate = self
        setClosureToLayerTableVC()
    }
    
    private func setClosureToLayerTableVC() {
        guard let layerTableVC = splitViewController?.viewController(for: .supplementary) as? LayerTableViewController else { return }
        layerTableVC.didSelectRowHandler = { selected in
            self.plane.select(layer: selected)
        }
        
        layerTableVC.didMoveRowHandler = { fromIndex, toIndex in
            self.plane.reorderLayer(from: fromIndex, to: toIndex)
        }
        
    }
}


// MARK: - Use case: Launch App

extension CanvasViewController {
    
    private func observePlane() {
        NotificationCenter.default.addObserver(self, selector: #selector(didAddLayer(_:)), name: Plane.Event.didAddLayer, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectLayer(_:)), name: Plane.Event.didSelectLayer, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeColor(_:)), name: Plane.Event.didChangeColor, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeAlpha(_:)), name: Plane.Event.didChangeAlpha, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrigin(_:)), name: Plane.Event.didChangeOrigin, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSize(_:)), name: Plane.Event.didChangeSize, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeText(_:)), name: Plane.Event.didChangeText, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didReorderLayer(_:)), name: Plane.Event.didReorderLayer, object: nil)
        
    }
    
    private func observePanel() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeSlider(_:)), name: PanelViewController.Event.didChangeSlider, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTouchColorButton(_:)), name: PanelViewController.Event.didTouchColorButton, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTouchOriginStepper(_:)), name: PanelViewController.Event.didTouchOriginStepper, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTouchSizeStepper(_:)), name: PanelViewController.Event.didTouchSizeStepper, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEditTextField(_:)), name: PanelViewController.Event.didEditTextField, object: nil)
    }
    
    private func setUpRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    private func setUpInitialModels() {
        (0..<4).forEach { _ in plane.add(layerType: .rectangle) }
    }
    
    private func setUpTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
}



// MARK: - Use Case: Add New Rectangle

extension CanvasViewController {
    
    @IBAction func didTouchRectangleButton(_ sender: UIButton) {
        plane.add(layerType: .rectangle)
    }
    
    @objc func didAddLayer(_ notification: Notification) {
        guard let newLayer = notification.userInfo?[Plane.InfoKey.added] as? Layer else { return }
        guard let newView = ViewFactory.create(from: newLayer) else { return }
        
        map(newView, to: newLayer)
        
        if newView is UILabel { resizeToFit(newLayer, for: newView) }
        
        view.addSubview(newView)
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

// MARK: - Use Case: Add New Photo

extension CanvasViewController {
    
    @IBAction func didTouchPhotoButton(_ sender: UIButton) {
        present(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage,
              let imageData = image.pngData() else { return }
        
        plane.add(layerType: .photo, data: imageData)
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Use Case: Touch label button (Input) & Add New Label (Output)

extension CanvasViewController {
    @IBAction func didTouchLabelButton(_ sender: UIButton) {
        plane.add(layerType: .label)
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
        let location = gesture.location(in: view)
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

// MARK: - Use Case: Touch Color Button (Input) & Change Color (Output)

extension CanvasViewController {
    
    @objc func didTouchColorButton(_ notification: Notification) {
        plane.changeSelected()
    }
    
    @objc func didChangeColor(_ notification: Notification) {
        guard let selected = plane.selected,
              let newColor = notification.userInfo?[Plane.InfoKey.changed] as? Color else { return }
        let mutatedUIView = search(for: selected)
        mutatedUIView?.backgroundColor = UIColor(with: newColor)
    }
}

// MARK: - Use Case: Change slider (Input) & Change Alpha (Output)

extension CanvasViewController {
    
    @objc func didChangeSlider(_ notification: Notification) {
        guard let value = notification.userInfo?[PanelViewController.InfoKey.value] as? Float else { return }
        
        if let alpha = Alpha(value) {
            plane.changeSelected(toAlpha: alpha)
        }
    }
    
    @objc func didChangeAlpha(_ notification: Notification) {
        guard let selected = plane.selected,
              let newAlpha = notification.userInfo?[Plane.InfoKey.changed] as? Alpha else { return }
        let mutatedUIView = search(for: selected)
        mutatedUIView?.alpha = CGFloat(with: newAlpha)
    }
    
}

// MARK: - Use Case: Touch origin stepper (Input) & Change origin (Output)

extension CanvasViewController {

    @objc func didTouchOriginStepper(_ notification: Notification) {
        guard let origin = notification.userInfo?[PanelViewController.InfoKey.origin] as? Point else { return }
        plane.changeSelected(toOrigin: origin)
    }
    
    @objc func didChangeOrigin(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.changed] as? Layer else { return }
        let mutatedCavnasView = search(for: mutated)
        mutatedCavnasView?.frame.origin = CGPoint(with: mutated.origin)
    }
}

// MARK: - Use Case: Touch size stepper slider (Input) & Change size (Output)

extension CanvasViewController {

    
    @objc func didTouchSizeStepper(_ notification: Notification) {
        guard let size = notification.userInfo?[PanelViewController.InfoKey.size] as? Size else { return }
        plane.changeSelected(toSize: size)
    }
    
    @objc func didChangeSize(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.changed] as? Layer else { return }
        let mutatedUIView = search(for: mutated)
        mutatedUIView?.frame.size = CGSize(with: mutated.size)
    }
}

// MARK: - Use Case: Edit textfield (Input) & Change text (Output)

extension CanvasViewController {

    
    @objc func didEditTextField(_ notification: Notification) {
        guard let text = notification.userInfo?[PanelViewController.InfoKey.text] as? String else { return }
        plane.changeSelected(toText: text)
    }
    
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
        view.addSubview(temporaryView)
    }
    
    private func drag(_ gesture: UIPanGestureRecognizer) {
        guard let temporaryView = temporaryView else { return }
        
        let translation = gesture.translation(in: view)
        temporaryView.center = CGPoint(
            x: temporaryView.center.x + translation.x,
            y: temporaryView.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: view)
        
        displayTemporaryOrigin(temporaryView)
    }
    
    private func displayTemporaryOrigin(_ temporaryView: UIView) {
        let temporaryOrigin = Point(x: temporaryView.frame.origin.x, y: temporaryView.frame.origin.y)
        NotificationCenter.default.post(name: CanvasViewController.Event.isDragging, object: self, userInfo: [CanvasViewController.InfoKey.origin: temporaryOrigin])
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

// MARK: - Use Case: Reorder Layers

extension CanvasViewController {
    @objc func didReorderLayer(_ notification: Notification) {
        guard let reorderedLayers = notification.userInfo?[Plane.InfoKey.changed] as? [Layer] else { return }

        for subView in view.subviews {
            subView.removeFromSuperview()
        }
        
        for layer in reorderedLayers {
            guard let layerView = layerMap[layer] else { return }
            view.addSubview(layerView)
        }
    }
}
