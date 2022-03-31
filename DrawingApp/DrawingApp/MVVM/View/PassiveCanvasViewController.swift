//
//  PassiveCanvasViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/30.
//

import UIKit

class PassiveCanvasViewController: UIViewController,
                                   UIImagePickerControllerDelegate,
                                   UINavigationControllerDelegate {
    
    var container: DIContainable? = nil
    private var canvasView: UIView?
    private var canvasViewModel: CanvasViewModel? = nil
    
    private let buttonTagToType: [Int: Layer.Type] = [1: Rectangle.self, 2: Photo.self, 3: Label.self, 4: PostIt.self]
    
    @IBOutlet weak var addRectangleButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var addLabelButton: UIButton!
    @IBOutlet weak var addPostItButton: UIButton!
    
    private lazy var photoPicker: UIImagePickerController = {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        return photoPicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCanvasView()
        setUpTapRecognizer()
        
        setViewModel()
        bindToViewModel()
    }
}

// MARK: - Initial Setup

extension PassiveCanvasViewController {
    
    private func setViewModel() {
        canvasViewModel = container?.resolve(type: CanvasViewModel.self)
    }
    
    private func bindToViewModel() {
        canvasViewModel?.newView.bind { [weak self] view in
            guard let view = view else { return }
            self?.canvasView?.addSubview(view)
        }
        
        canvasViewModel?.selectedView.bind { [weak self] view in
            guard let view = view else { return }
            self?.changeBorder(view)
        }
        
        canvasViewModel?.unselectedView.bind { [weak self] view in
            guard let view = view else { return }
            self?.clearBorder(view)
        }
    }
    
    private func setCanvasView() {
        let canvasView = UIView()
        self.canvasView = canvasView
        
        // CanvasView should be set behind of existing subviews, in front of KPT layouts
        view.insertSubview(canvasView, at: 1)
        
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setUpTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        canvasView?.addGestureRecognizer(tap)
    }
}

// MARK: - Use case: Add new Layer

extension PassiveCanvasViewController {
    
    @IBAction func addButtonTouched(_ sender: UIButton) {
        guard let layerType = buttonTagToType[sender.tag] else { return }
        
        if layerType == Photo.self {
            present(photoPicker, animated: true, completion: nil)
        }
        
        canvasViewModel?.add(of: layerType)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage,
              let imageData = image.pngData() else { return }
        
        canvasViewModel?.add(of: Photo.self, imageData: imageData)
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Use case: Tap to select & unselect

extension PassiveCanvasViewController {
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: canvasView)
        let tappedPoint = Point(x: location.x, y: location.y)
        canvasViewModel?.select(on: tappedPoint)
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
