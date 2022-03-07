//
//  ViewController.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    let rectangleViewBoard = UIView()
    let rectanglePropertyChangeBoard = PropertyChangeBoard()
    let addRectangleButton = UIButton()
   
    
    let rectangleFactory = RectangleFactory(screenSize: (800, 570))
    let rectangleViewFactory = RectangleViewFactory()
    let plane = Plane()
    
    var selectedRectangle : Rectangle? = nil
    var selectedRectangleView : UIView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialScreenSetUp()
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
                        
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:)))
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
        guard let newRectangle = rectangleFactory.makeRandomRectangle() else {return}
        let newRectangleView = rectangleViewFactory.makeNewRectangleView(rectangle: newRectangle)
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:)))
        plane.addRectangle(rectangle: newRectangle)
        newRectangleView.addGestureRecognizer(tap)
        self.rectangleViewBoard.addSubview(newRectangleView)
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        if self.selectedRectangleView != nil {
            self.selectedRectangleView?.layer.borderWidth = 0
            self.selectedRectangleView = nil
        }
        if gestureRecognizer.view != self.rectangleViewBoard {
            self.selectedRectangleView = gestureRecognizer.view
            self.selectedRectangleView?.layer.borderWidth = 2
            self.selectedRectangleView?.layer.borderColor = UIColor.blue.cgColor
        }
        
        guard let color = self.selectedRectangleView?.backgroundColor?.cgColor.components else {
            self.rectanglePropertyChangeBoard.colorChangeButton.setTitle("", for: .normal)
            self.rectanglePropertyChangeBoard.alphaChangeSlider.value = 0
            return
        }
        let red = Int(color[0] * 255)
        let green = Int(color[1] * 255)
        let blue = Int(color[2] * 255)
        let alpha = Float(color[3] * 10)
        
        self.rectanglePropertyChangeBoard.colorChangeButton.setTitle("\(String(format: "#%02X%02X%02x", red, green, blue))", for: .normal)
        self.rectanglePropertyChangeBoard.alphaChangeSlider.value = alpha
    }
}

