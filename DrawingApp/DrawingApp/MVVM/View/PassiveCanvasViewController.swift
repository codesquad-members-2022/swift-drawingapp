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
    
    private var canvasView: UIView?
    private let canvasViewModel = CanvasViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCanvasView()
        setUpTapRecognizer()
        bindToViewModel()
    }
    
    private func bindToViewModel() {
        canvasViewModel.newView.bind { [weak self] view in
            guard let view = view else { return }
            self?.canvasView?.addSubview(view)
        }
        
        canvasViewModel.selectedView.bind { [weak self] view in
            guard let view = view else { return }
            self?.changeBorder(view)
        }
        
        canvasViewModel.unselectedView.bind { [weak self] view in
            guard let view = view else { return }
            self?.clearBorder(view)
        }
    }
    
    @IBAction func RectangleButtonTouched(_ sender: UIButton) {
        canvasViewModel.add(of: Rectangle.self)
    }
    
    @IBAction func LabelButtonTouched(_ sender: UIButton) {
        canvasViewModel.add(of: Label.self)
    }
    
    @IBAction func PostItButtonTouched(_ sender: UIButton) {
        canvasViewModel.add(of: PostIt.self)
    }
    
    @IBAction func PhotoButtonTouched(_ sender: UIButton) {
        present(photoPicker, animated: true, completion: nil)
        canvasViewModel.add(of: Photo.self)
    }
    
    private lazy var photoPicker: UIImagePickerController = {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        return photoPicker
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage,
              let imageData = image.pngData() else { return }
        
        canvasViewModel.add(of: Photo.self, imageData: imageData)
        picker.dismiss(animated: true, completion: nil)
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
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: canvasView)
        let tappedPoint = Point(x: location.x, y: location.y)
        canvasViewModel.select(on: tappedPoint)
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
