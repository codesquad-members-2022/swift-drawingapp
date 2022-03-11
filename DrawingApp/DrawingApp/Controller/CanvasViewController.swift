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
    private var viewModelMap = [ViewModel: UIView]()
    private var viewMap = [UIView: ViewModel]()
    private let photoPicker = UIImagePickerController()
    private var temporaryView: UIView?
    
    enum Event {
        static let drag = Notification.Name("drag")
    }
    
    enum InfoKey {
        static let newOrigin = "origin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observePlane()
        observePanel()
        
        setUpInitialModels()
        setUpTapRecognizer()
        
        photoPicker.delegate = self
    }
}


// MARK: - Use case: Launch App

extension CanvasViewController {
    
    private func observePlane() {
        NotificationCenter.default.addObserver(self, selector: #selector(didAddViewModel(_:)), name: Plane.Event.addViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectViewModel(_:)), name: Plane.Event.selectViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateColor(_:)), name: Plane.Event.mutateColorViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateAlpha(_:)), name: Plane.Event.mutateAlphaViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateOrigin(_:)), name: Plane.Event.mutateOriginViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateSize(_:)), name: Plane.Event.mutateSizeViewModel, object: plane)
    }
    
    private func observePanel() {
        NotificationCenter.default.addObserver(self, selector: #selector(sliderChanged(_:)), name: PanelViewController.Event.sliderChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(colorButtonPressed(_:)), name: PanelViewController.Event.colorButtonPressed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(originStepperChanged(_:)), name: PanelViewController.Event.originStepperChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sizeStepperChanged(_:)), name: PanelViewController.Event.sizeStpperChanged, object: nil)
    }
    
    private func setUpRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    private func setUpInitialModels() {
        (0..<4).forEach { _ in plane.addRectangle() }
    }
    
    private func setUpTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
}



// MARK: - Use Case: Add New Rectangle

extension CanvasViewController {
    
    @IBAction func addRectanglePressed(_ sender: UIButton) {
        plane.addRectangle()
    }
    
    @objc func didAddViewModel(_ notification: Notification) {
        guard let newViewModel = notification.userInfo?[Plane.InfoKey.new] as? ViewModel else { return }
        guard let newView = ViewFactory.create(from: newViewModel) else { return }
        
        map(newView, to: newViewModel)
        
        if newView is UILabel { resizeToFit(newViewModel, for: newView) }
        
        view.addSubview(newView)
        setupPanRecognizer(newView)
    }
    
    private func createView(from viewModel: ViewModel) -> UIView? {
        return ViewFactory.create(from: viewModel)
    }
    
    private func map(_ view: UIView, to viewModel: ViewModel) {
        viewModelMap[viewModel] = view
        viewMap[view] = viewModel
    }
}

// MARK: - Use Case: Add New Photo

extension CanvasViewController {
    
    @IBAction func addPhotoPressed(_ sender: UIButton) {
        present(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage,
              let imageData = image.pngData() else { return }
        
        plane.addPhoto(data: imageData)
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Use Case: Add New Label

extension CanvasViewController {
    @IBAction func addLabelPressed(_ sender: UIButton) {
        plane.addLabel()
    }
    
    private func resizeToFit(_ viewModel: ViewModel, for view: UIView) {
        let fitSize = Size(width: view.intrinsicContentSize.width, height: view.intrinsicContentSize.height)
        plane.set(viewModel: viewModel, to: fitSize)
    }
}

// MARK: - Use Case: Select CanvasView

extension CanvasViewController {
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        let tappedPoint = Point(x: location.x, y: location.y)
        plane.tap(on: tappedPoint)
    }
    
    @objc func didSelectViewModel(_ notification: Notification) {
        if let new = notification.userInfo?[Plane.InfoKey.new] as? ViewModel {
            guard let newView = search(for: new) else { return }
            changeBorder(newView)
        }
        
        if let old = notification.userInfo?[Plane.InfoKey.old] as? ViewModel {
            guard let oldView = search(for: old) else { return }
            clearBorder(oldView)
        }
    }
    
    private func search(for viewModel: ViewModel) -> UIView? {
        return viewModelMap[viewModel]
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

// MARK: - Use Case: Change CanvasView

extension CanvasViewController {
    
    @objc func colorButtonPressed(_ notification: Notification) {
        plane.set()
    }
    
    @objc func didMutateColor(_ notification: Notification) {
        guard let selected = plane.selected,
              let newColor = notification.userInfo?[Plane.InfoKey.new] as? Color else { return }
        let mutatedUIView = search(for: selected)
        mutatedUIView?.backgroundColor = UIColor(with: newColor)
    }
    
    @objc func sliderChanged(_ notification: Notification) {
        guard let value = notification.userInfo?[PanelViewController.InfoKey.sliderValue] as? Float else { return }
        
        if let alpha = Alpha(value) {
            plane.set(to: alpha)
        }
    }
    
    @objc func didMutateAlpha(_ notification: Notification) {
        guard let selected = plane.selected,
              let newAlpha = notification.userInfo?[Plane.InfoKey.new] as? Alpha else { return }
        let mutatedUIView = search(for: selected)
        mutatedUIView?.alpha = CGFloat(with: newAlpha)
    }
    
    @objc func originStepperChanged(_ notification: Notification) {
        guard let origin = notification.userInfo?[PanelViewController.InfoKey.newOrigin] as? Point else { return }
        plane.set(to: origin)
    }
    
    @objc func didMutateOrigin(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.mutated] as? ViewModel else { return }
        let mutatedCavnasView = search(for: mutated)
        mutatedCavnasView?.frame.origin = CGPoint(with: mutated.origin)
    }
    
    @objc func sizeStepperChanged(_ notification: Notification) {
        guard let size = notification.userInfo?[PanelViewController.InfoKey.newSize] as? Size else { return }
        plane.set(to: size)
    }
    
    @objc func didMutateSize(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.mutated] as? ViewModel else { return }
        let mutatedUIView = search(for: mutated)
        mutatedUIView?.frame.size = CGSize(with: mutated.size)
    }
}

// MARK: - Use Case: Drag CanvasView

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
        
        let temporaryView = ViewFactory.clone(gestureView)
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
        NotificationCenter.default.post(name: CanvasViewController.Event.drag, object: self, userInfo: [CanvasViewController.InfoKey.newOrigin: temporaryOrigin])
    }
    
    private func endPan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view,
              let gestureViewModel = viewMap[gestureView],
              let temporaryView = temporaryView,
              gesture.state == .ended else { return }
        
        let lastOrigin = Point(x: temporaryView.frame.origin.x,
                               y: temporaryView.frame.origin.y)
        
        plane.drag(viewModel: gestureViewModel, to: lastOrigin)
        temporaryView.removeFromSuperview()
    }
    
    private func search(for view: UIView) -> ViewModel? {
        return viewMap[view]
    }
}
