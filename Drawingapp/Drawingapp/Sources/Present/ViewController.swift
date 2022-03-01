//
//  ViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {

    let drawingBoard = UIView()
    
    let makeSquareIcon = UIImageView()
    let makeSquareLabel = UILabel()
    let makeSquare = UIButton()
    
    var squareViews: [String:UIView] = [:]
    
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        attribute()
        layout()
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.drawingBoard.addGestureRecognizer(tapGesture)
    }
    
    func bind() {
        makeSquare.addAction(UIAction(){ _ in
            self.plane.action.makeSquareButtonTapped()
        }, for: .touchUpInside)
        
        plane.state.drawSquare = { square in
            let squareView = UIView()
            self.drawingBoard.addSubview(squareView)
            squareView.backgroundColor = square.color.uiColor
            squareView.frame = CGRect(x: square.x, y: square.y, width: square.width, height: square.height)
            self.squareViews[square.id] = squareView
        }
    }
    
    func attribute() {
        self.view.backgroundColor = .black
        
        drawingBoard.backgroundColor = .white
        
        makeSquare.backgroundColor = .lightGray
        makeSquare.layer.cornerRadius = 5
        makeSquare.layer.borderColor = UIColor.black.cgColor
        makeSquare.layer.borderWidth = 1
        
        makeSquareIcon.image = UIImage(named: "ic_square")
        
        makeSquareLabel.text = "사각형"
        makeSquareLabel.textColor = .black
    }
    
    func layout() {
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(drawingBoard)
        drawingBoard.translatesAutoresizingMaskIntoConstraints = false
        drawingBoard.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        drawingBoard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        drawingBoard.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        drawingBoard.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.drawingBoard.addSubview(makeSquare)
        makeSquare.translatesAutoresizingMaskIntoConstraints = false
        makeSquare.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        makeSquare.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor).isActive = true
        makeSquare.widthAnchor.constraint(equalToConstant: 100).isActive = true
        makeSquare.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.makeSquare.addSubview(makeSquareIcon)
        makeSquareIcon.translatesAutoresizingMaskIntoConstraints = false
        makeSquareIcon.topAnchor.constraint(equalTo: makeSquare.topAnchor, constant: 10 ).isActive = true
        makeSquareIcon.centerXAnchor.constraint(equalTo: makeSquare.centerXAnchor).isActive = true
        makeSquareIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        makeSquareIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.makeSquare.addSubview(makeSquareLabel)
        makeSquareLabel.translatesAutoresizingMaskIntoConstraints = false
        makeSquareLabel.bottomAnchor.constraint(equalTo: makeSquare.bottomAnchor, constant: -10).isActive = true
        makeSquareLabel.centerXAnchor.constraint(equalTo: makeSquare.centerXAnchor).isActive = true
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let location = gestureRecognizer.location(in: gestureRecognizer.view)
        self.plane.action.onScreenTapped(Point(x: location.x, y: location.y))
        return true
    }
}
