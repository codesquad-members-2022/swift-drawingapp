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
    private var rectangleMap = [Rectangle: CanvasView]()
    private var photoMap = [Photo: CanvasView]()
    private let photoPicker = UIImagePickerController()
    private var temporaryView: UIImageView?
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(didAddViewModel(_:)), name: Plane.event.addViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectViewModel(_:)), name: Plane.event.selectViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateColor(_:)), name: Plane.event.mutateColorViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateAlpha(_:)), name: Plane.event.mutateAlphaViewModel, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateOrigin(_:)), name: Plane.event.mutateOriginViewModel, object: plane)
    }
    
    private func observePanel() {
        NotificationCenter.default.addObserver(self, selector: #selector(sliderChanged(_:)), name: PanelViewController.event.sliderChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(colorButtonPressed(_:)), name: PanelViewController.event.colorButtonPressed, object: nil)
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
        guard let newViewModel = notification.userInfo?[Plane.InfoKey.new] as? Rectangle else { return }
        let newCanvasView = createView(from: newViewModel)
        add(canvasView: newCanvasView, to: newViewModel)
        view.addSubview(newCanvasView)
        setupPanRecognizer(newCanvasView)
    }
    
    private func createView<T: ViewModel>(from viewModel: T) -> CanvasView {
        return CanvasView.create(from: viewModel)
    }
    
    private func add(canvasView: CanvasView, to viewModel: ViewModel) {
        if let rectangle = viewModel as? Rectangle {
            rectangleMap[rectangle] = canvasView
        } else if let photo = viewModel as? Photo {
            photoMap[photo] = canvasView
        }
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

// MARK: - Use Case: Select CanvasView

extension CanvasViewController {
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        let tappedPoint = Point(x: location.x, y: location.y)
        plane.tap(on: tappedPoint)
    }
    
    @objc func didSelectViewModel(_ notification: Notification) {
        if let new = notification.userInfo?[Plane.InfoKey.new] as? ViewModel {
            guard let newView = searchView(for: new) else { return }
            changeBorder(newView)
        }
        
        if let old = notification.userInfo?[Plane.InfoKey.old] as? ViewModel {
            guard let oldView = searchView(for: old) else { return }
            clearBorder(oldView)
        }
    }
    
    private func search(for viewModel: ViewModel) -> CanvasView? {
        if let rectangle = viewModel as? Rectangle {
            return rectangleMap[rectangle]
        } else if let photo = viewModel as? Photo {
            return photoMap[photo]
        }
    }
    
    private func changeBorder(_ view: CanvasView) {
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func clearBorder(_ view: CanvasView) {
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.clear.cgColor
    }
}

// MARK: - Use Case: Transform CanvasView

extension CanvasViewController {
    
    @objc func colorButtonPressed(_ notification: Notification) {
        plane.set()
    }
    
    @objc func didMutateColor(_ notification: Notification) {
        guard let plane = notification.object as? Plane,
              let mutated = plane.selected as? ColorMutable else { return }
        let mutatedUIView = searchView(for: mutated as! ViewModel)
        mutatedUIView?.backgroundColor = UIColor(with: mutated.color)
    }
    
    @objc func sliderChanged(_ notification: Notification) {
        guard let value = notification.userInfo?[PanelViewController.InfoKey.sliderValue] as? Float else { return }
        
        if let alpha = Alpha(value) {
            plane.set(to: alpha)
        }
    }
    
    @objc func didMutateAlpha(_ notification: Notification) {
        guard let plane = notification.object as? Plane,
              let mutated = plane.selected as? AlphaMutable else { return }
        let mutatedUIView = searchView(for: mutated as! ViewModel)
        mutatedUIView?.alpha = CGFloat(with: mutated.alpha)
    }
}

// MARK: - Use Case: Drag CanvasView

extension CanvasViewController {
    
    private func setupPanRecognizer(_ canvasView: CanvasView) {
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
        guard let gestureView = gesture.view as? CanvasView,
              gesture.state == .began else { return }
        
        let temporaryView = gestureView.createTemporary()
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
    }
    
    private func endPan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view as? CanvasView,
              let temporaryView = temporaryView,
              gesture.state == .ended else { return }
        
        let lastOrigin = Point(x: temporaryView.frame.origin.x,
                               y: temporaryView.frame.origin.y)
        
        plane.set(gestureView, to: lastOrigin)
        temporaryView.removeFromSuperview()
    }
    
    private func search(for canvasView: CanvasView) -> ViewModel? {
        if let rectangle = viewModel as? Rectangle {
            return rectangleMap.first { dict in
                dict.value === canvasView
            }
        } else if let photo = viewModel as? Photo {
            return photoMap[photo]
        }
    }
    
    @objc func didMutateOrigin(_ notification: Notification) {
        guard let mutated = notification.userInfo?[Plane.InfoKey.muatated] as? OriginMutable else { return }
        
        let mutatedCavnasView = searchView(for: mutated as! ViewModel)
        mutatedCavnasView?.frame.origin = CGPoint(with: mutated.origin)
    }
}
