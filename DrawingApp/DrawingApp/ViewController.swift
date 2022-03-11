//
//  ViewController.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    let rectangleViewBoard = RectangleViewBoard()
    let rectanglePropertyChangeBoard = PropertyChangeBoard()
    let addRectangleButton = UIButton()
   
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rectanglePropertyChangeBoard.delegate = self
        rectangleViewBoard.delegate = self
        initialScreenSetUp()
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidAdd(_:)), name: Plane.addRectangle, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidSearch(_:)), name: Plane.searchRectangle, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(planeDidUpdated(_:)), name: Plane.updateAlpha , object: nil)
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
        
        layoutViewBoard()
        layoutPropertyBoard()
        layoutAddRectangleButton()
    }
    
    @objc func addNewRectangle() {
        guard let newRectangle = RectangleFactory.makeRandomRectangle(in: (800, 570)) else {return}
        plane.addRectangle(rectangle: newRectangle)
    }
    
    @objc func tapRectangleViewBoard(_ gestureRecognizer: UITapGestureRecognizer) {
        let touchedLocation = gestureRecognizer.location(in: gestureRecognizer.view)
        let touchedPosition = Position(x: touchedLocation.x, y: touchedLocation.y)
        plane.searchRectangle(at: touchedPosition)
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
        guard let rectangle = notification.userInfo?["rectangle"] as? Rectangle else {return}
        let rectangleView = RectangleViewFactory.makeView(of: rectangle)
        self.rectangleViewBoard.addSubview(rectangleView)
    }
    
    @objc func planeDidSearch(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else {return}
        guard let rectangle = notification.userInfo?["rectangle"] as? Rectangle else {return}
        self.rectangleViewBoard.setSelectedRectangleView(at: index)
        self.rectanglePropertyChangeBoard.setPropertyBoard(with: rectangle)
    }
    
    @objc func planeDidUpdated(_ notification: Notification) {
        guard let alpha = notification.userInfo?["alpha"] as? Alpha else {return}
        self.rectangleViewBoard.updateAlpha(alpha: alpha)
    }
    
    func plane(didChanged color: Color) {
        rectangleViewBoard.updateColor(color: color)
    }
}

extension ViewController: RectangleViewBoardDelegate {
    func rectangleViewBoard(didUpdated color: Color) {
        rectanglePropertyChangeBoard.updateColorButton(color: color)
    }
}
