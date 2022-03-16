//
//  ViewController.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    private let shapeViewBoard = ShapeViewBoard()
    private let shapePropertyChangeBoard = PropertyChangeBoard()
    private let addRectangleButton = UIButton()
    private let addPhotoButton = UIButton()
    
    private var viewFinder : [Shape?: ShapeViewAble?] = [:]
    
    let imagePickerController = UIImagePickerController()
    
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapePropertyChangeBoard.delegate = self
        shapeViewBoard.delegate = self
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
            view.addSubview(shapeViewBoard)
            self.shapeViewBoard.translatesAutoresizingMaskIntoConstraints = false
            
            self.shapeViewBoard.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
            self.shapeViewBoard.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            self.shapeViewBoard.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.9).isActive = true
            self.shapeViewBoard.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8).isActive = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapShapeViewBoard(_:)))
            self.shapeViewBoard.addGestureRecognizer(tap)
            self.shapeViewBoard.clipsToBounds = true
        }
        
        func layoutPropertyBoard() {
            view.addSubview(shapePropertyChangeBoard)
            self.shapePropertyChangeBoard.translatesAutoresizingMaskIntoConstraints = false
            
            self.shapePropertyChangeBoard.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
            self.shapePropertyChangeBoard.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.2).isActive = true
            self.shapePropertyChangeBoard.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
            self.shapePropertyChangeBoard.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        }
        
        func layoutAddRectangleButton() {
            view.addSubview(addRectangleButton)
            addRectangleButton.translatesAutoresizingMaskIntoConstraints = false
            
            addRectangleButton.setTitle("사각형 추가", for: .normal)
            addRectangleButton.setTitleColor(.black, for: .normal)
            
            addRectangleButton.layer.borderWidth = 1
            addRectangleButton.layer.borderColor = UIColor.black.cgColor
            addRectangleButton.layer.cornerRadius = 10
            
            addRectangleButton.topAnchor.constraint(equalTo: shapeViewBoard.bottomAnchor, constant: 10).isActive = true
            addRectangleButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
            addRectangleButton.widthAnchor.constraint(equalTo: shapeViewBoard.widthAnchor, multiplier: 0.1).isActive = true
            addRectangleButton.centerXAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: shapeViewBoard.safeAreaLayoutGuide.layoutFrame.width/2).isActive = true
            
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
            
            addPhotoButton.topAnchor.constraint(equalTo: shapeViewBoard.bottomAnchor, constant: 10).isActive = true
            addPhotoButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
            addPhotoButton.widthAnchor.constraint(equalTo: shapeViewBoard.widthAnchor, multiplier: 0.1).isActive = true
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
    
    @objc func tapShapeViewBoard(_ gestureRecognizer: UITapGestureRecognizer) {
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
            if let shapeView = ShapeViewFactory.makeView(of: shape) {
                viewFinder[shape] = shapeView
                guard let shapeView = shapeView as? UIView else {return}
                self.shapeViewBoard.addSubview(shapeView)
            }
        }
    }
    
    @objc func planeDidSearch(_ notification: Notification) {
        let shape = notification.userInfo?[Plane.NotificationKeyValue.shape] as? Shape
        let selectedView = viewFinder[shape] as? ShapeViewAble
        self.shapeViewBoard.setSelectedView(of: selectedView)
        self.shapePropertyChangeBoard.setPropertyBoard(with: shape)
    }
    
    @objc func planeDidUpdated(_ notification: Notification) {
        guard let alpha = notification.userInfo?[Plane.NotificationKeyValue.alpha] as? Alpha else {return}
        self.shapeViewBoard.updateAlpha(alpha: alpha)
    }
    
    @objc func planeDidChanged(_ notification: Notification) {
        guard let color = notification.userInfo?[Plane.NotificationKeyValue.color] as? Color else {return}
        shapeViewBoard.updateColor(color: color)
    }
}

extension ViewController: ShapeViewBoardDelegate {
    func shapeViewBoard(didUpdated color: Color) {
        shapePropertyChangeBoard.updateColorButton(color: color)
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
