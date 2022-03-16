//
//  ViewController.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    private let rectangleViewBoard = RectangleViewBoard()
    private let rectanglePropertyChangeBoard = PropertyChangeBoard()
    private let addRectangleButton = UIButton()
    private let addPhotoButton = UIButton()
    
    private var viewFinder : [Shape: RectangleView] = [:]
    
    let imagePickerController = UIImagePickerController()
    
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rectanglePropertyChangeBoard.delegate = self
        rectangleViewBoard.delegate = self
        imagePickerController.delegate = self
        initialScreenSetUp()
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidAdd(_:)), name: Plane.NotificationName.addShape, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidSearch(_:)), name: Plane.NotificationName.searchShape, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidUpdated(_:)), name: Plane.NotificationName.updateAlpha , object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidChanged(_:)), name: Plane.NotificationName.changeColor, object: plane)
    }
    
    func initialScreenSetUp() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        func layoutViewBoard() {
            view.addSubview(rectangleViewBoard)
            self.rectangleViewBoard.translatesAutoresizingMaskIntoConstraints = false
            
            self.rectangleViewBoard.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            self.rectangleViewBoard.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            self.rectangleViewBoard.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.9).isActive = true
            self.rectangleViewBoard.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8).isActive = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapRectangleViewBoard(_:)))
            self.rectangleViewBoard.addGestureRecognizer(tap)
            self.rectangleViewBoard.clipsToBounds = true
        }
        
        func layoutPropertyBoard() {
            view.addSubview(rectanglePropertyChangeBoard)
            self.rectanglePropertyChangeBoard.translatesAutoresizingMaskIntoConstraints = false
            
            self.rectanglePropertyChangeBoard.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            self.rectanglePropertyChangeBoard.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.2).isActive = true
            self.rectanglePropertyChangeBoard.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            self.rectanglePropertyChangeBoard.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        }
        
        func layoutAddRectangleButton() {
            view.addSubview(addRectangleButton)
            addRectangleButton.translatesAutoresizingMaskIntoConstraints = false
            
            addRectangleButton.setTitle("사각형 추가", for: .normal)
            addRectangleButton.setTitleColor(.black, for: .normal)
            
            addRectangleButton.layer.borderWidth = 1
            addRectangleButton.layer.borderColor = UIColor.black.cgColor
            addRectangleButton.layer.cornerRadius = 10
            
            addRectangleButton.topAnchor.constraint(equalTo: rectangleViewBoard.bottomAnchor, constant: 10).isActive = true
            addRectangleButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
            addRectangleButton.widthAnchor.constraint(equalTo: rectangleViewBoard.widthAnchor, multiplier: 0.1).isActive = true
            addRectangleButton.centerXAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: rectangleViewBoard.safeAreaLayoutGuide.layoutFrame.width/2).isActive = true
            
            addRectangleButton.addTarget(self, action: #selector(addNewRectangle), for: .touchUpInside)
        }
        
        func layoutAddPhotoButton() {
            view.addSubview(addPhotoButton)
            addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
            
            addPhotoButton.setTitle("사진 추가", for: .normal)
            addPhotoButton.setTitleColor(.black, for: .normal)
            
            addPhotoButton.layer.borderWidth = 1
            addPhotoButton.layer.borderColor = UIColor.black.cgColor
            addPhotoButton.layer.cornerRadius = 10
            
            addPhotoButton.topAnchor.constraint(equalTo: rectangleViewBoard.bottomAnchor, constant: 10).isActive = true
            addPhotoButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
            addPhotoButton.widthAnchor.constraint(equalTo: rectangleViewBoard.widthAnchor, multiplier: 0.1).isActive = true
            addPhotoButton.leftAnchor.constraint(equalTo: addRectangleButton.rightAnchor, constant: 10).isActive = true
            
            addPhotoButton.addTarget(self, action: #selector(selectPhotoButtonTouched), for: .touchUpInside)
        }
        
        layoutViewBoard()
        layoutPropertyBoard()
        layoutAddRectangleButton()
        layoutAddPhotoButton()
    }
    
    @objc func addNewRectangle() {
        guard let newShape = ShapeFactory.makeRandomShape(in: (800, 570)) else {return}
        plane.addShape(shape: newShape)
    }
    
    @objc func tapRectangleViewBoard(_ gestureRecognizer: UITapGestureRecognizer) {
        let touchedLocation = gestureRecognizer.location(in: gestureRecognizer.view)
        let touchedPosition = Position(x: touchedLocation.x, y: touchedLocation.y)
        plane.searchShape(at: touchedPosition)
    }
    
    @objc func selectPhotoButtonTouched(_ sender: Any) {
            let pickerAlert = UIAlertController(title: "사진 가져오기", message: "", preferredStyle: .actionSheet )

            let libraryOption = UIAlertAction(title: "앨범", style: .default){
                _ in self.present(self.imagePickerController, animated: true)
            }
            let cancelOption = UIAlertAction(title: "취소", style: .cancel)
            
            pickerAlert.addAction(libraryOption)
            pickerAlert.addAction(cancelOption)
            
            if let popoverController = pickerAlert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.present(pickerAlert, animated: true, completion: nil)
        }

}

extension ViewController: PropertyChangeBoardDelegate {
    func propertyChangeBoard(didChanged alpha: Alpha) {
        plane.updateAlphaValue(with: alpha)
    }
    
    func propertyChangeBoardDidTouchedColorButton() {
        let randomColor = RandomGenerator.generateColor()
        plane.changeRandomColor(to: randomColor)
    }
}

extension ViewController {
    @objc func planeDidAdd(_ notification: Notification) {
        if let shape = notification.userInfo?[Plane.NotificationKeyValue.shape] as? Shape {
            if let photoRectangleView = RectangleViewFactory.makeView(of: shape) {
                viewFinder[shape] = photoRectangleView
                self.rectangleViewBoard.addSubview(photoRectangleView)
            }
        }
    }
    
    @objc func planeDidSearch(_ notification: Notification) {
        guard let shape = notification.userInfo?[Plane.NotificationKeyValue.shape] as? Shape else {return}
        let selectedView = viewFinder[shape]
        self.rectangleViewBoard.setSelectedRectangleView(of: selectedView)
        self.rectanglePropertyChangeBoard.setPropertyBoard(with: shape)
    }
    
    @objc func planeDidUpdated(_ notification: Notification) {
        guard let alpha = notification.userInfo?[Plane.NotificationKeyValue.alpha] as? Alpha else {return}
        self.rectangleViewBoard.updateAlpha(alpha: alpha)
    }
    
    @objc func planeDidChanged(_ notification: Notification) {
        guard let color = notification.userInfo?[Plane.NotificationKeyValue.color] as? Color else {return}
        rectangleViewBoard.updateColor(color: color)
    }
}

extension ViewController: RectangleViewBoardDelegate {
    func rectangleViewBoard(didUpdated color: Color) {
        rectanglePropertyChangeBoard.updateColorButton(color: color)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            guard let data = try? Data(contentsOf: imageUrl) else {return}
            guard let photoShape = ShapeFactory.makePhotoShape(in: (800,570), imageData: data) else {return}
            plane.addShape(shape: photoShape)
        }
        dismiss(animated: true)
    }
}
