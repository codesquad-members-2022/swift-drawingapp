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
    let rectanglePropertyChangeBoard = UIView()
    let addRectangleButton = UIButton()
    let colorLabel = UILabel()
    let colorChangeButton = UIButton()
    let alphaLabel = UILabel()
    let alphaChangeSlider = UISlider()
    
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
        
        func layoutColorLabel() {
            rectanglePropertyChangeBoard.addSubview(colorLabel)
            colorLabel.translatesAutoresizingMaskIntoConstraints = false
            
            colorLabel.text = "배경색"

            colorLabel.topAnchor.constraint(equalTo: rectanglePropertyChangeBoard.topAnchor, constant: 40).isActive = true
            colorLabel.leadingAnchor.constraint(equalTo: rectanglePropertyChangeBoard.leadingAnchor, constant: 30).isActive = true
            colorLabel.trailingAnchor.constraint(equalTo: rectanglePropertyChangeBoard.trailingAnchor, constant: -30).isActive = true
            colorLabel.heightAnchor.constraint(equalTo: rectanglePropertyChangeBoard.heightAnchor, multiplier: 0.05).isActive = true
        }
        
        func layoutColorChangeButton() {
            rectanglePropertyChangeBoard.addSubview(colorChangeButton)
            colorChangeButton.translatesAutoresizingMaskIntoConstraints = false
            
            colorChangeButton.layer.borderWidth = 1
            colorChangeButton.layer.borderColor = UIColor.black.cgColor
            colorChangeButton.layer.cornerRadius = 10
            
            colorChangeButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 10).isActive = true
            colorChangeButton.heightAnchor.constraint(equalTo: rectanglePropertyChangeBoard.heightAnchor, multiplier: 0.05).isActive = true
            colorChangeButton.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor).isActive = true
            colorChangeButton.trailingAnchor.constraint(equalTo: colorLabel.trailingAnchor).isActive = true
        }
        
        func layoutAlphaLabel() {
            rectanglePropertyChangeBoard.addSubview(alphaLabel)
            alphaLabel.translatesAutoresizingMaskIntoConstraints = false
            
            alphaLabel.text = "투명도"
            
            alphaLabel.topAnchor.constraint(equalTo: colorChangeButton.bottomAnchor, constant: 40).isActive = true
            alphaLabel.heightAnchor.constraint(equalTo: rectanglePropertyChangeBoard.heightAnchor, multiplier: 0.05).isActive = true
            alphaLabel.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor).isActive = true
            alphaLabel.trailingAnchor.constraint(equalTo: colorLabel.trailingAnchor).isActive = true
        }
        
        func layoutAlphaChangeSlider() {
            rectanglePropertyChangeBoard.addSubview(alphaChangeSlider)
            alphaChangeSlider.translatesAutoresizingMaskIntoConstraints = false
            
            alphaChangeSlider.minimumValue = 1
            alphaChangeSlider.maximumValue = 10
            
            alphaChangeSlider.topAnchor.constraint(equalTo: alphaLabel.bottomAnchor, constant: 10).isActive = true
            alphaChangeSlider.heightAnchor.constraint(equalTo: rectanglePropertyChangeBoard.heightAnchor, multiplier: 0.05).isActive = true
            alphaChangeSlider.leadingAnchor.constraint(equalTo: colorLabel.leadingAnchor).isActive = true
            alphaChangeSlider.trailingAnchor.constraint(equalTo: colorLabel.trailingAnchor).isActive = true
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
        layoutColorLabel()
        layoutColorChangeButton()
        layoutAlphaLabel()
        layoutAlphaChangeSlider()
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
        }
        self.selectedRectangleView = gestureRecognizer.view
        self.selectedRectangleView?.layer.borderWidth = 2
        self.selectedRectangleView?.layer.borderColor = UIColor.blue.cgColor
    }
}

