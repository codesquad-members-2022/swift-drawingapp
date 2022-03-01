//
//  ViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    let drawingBoard = UIView()
    var squareViews: [String:SquareView] = [:]
    
    let topMenuBarView = TopMenuBarView()
    let inspectorView = InspectorView()
    
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
        topMenuBarView.bind(plane: self.plane)
        inspectorView.bind(plane: self.plane)
        
        plane.state.drawSquare = { square in
            let squareView = SquareView()
            squareView.setSquare(in: square)
            self.drawingBoard.addSubview(squareView)
            self.squareViews[square.id] = squareView
        }
        
        plane.state.didDisSelectedSquare = { square in
            guard let square = square else {
                return
            }
            self.squareViews[square.id]?.selected(is: false)
        }
        
        plane.state.didSelectedSquare = { square in
            self.inspectorView.setSquare(in: square)
            
            guard let square = square else {
                return
            }
            self.squareViews[square.id]?.selected(is: true)
        }
        
        plane.state.updateSquare = { square in
            self.squareViews[square.id]?.setSquare(in: square)
            self.inspectorView.setSquare(in: square)
        }
    }
    
    func attribute() {
        drawingBoard.backgroundColor = .white
    }
    
    func layout() {
        self.view.addSubview(drawingBoard)
        self.view.addSubview(inspectorView)
        self.view.addSubview(topMenuBarView)
        
        drawingBoard.translatesAutoresizingMaskIntoConstraints = false
        drawingBoard.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        drawingBoard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        drawingBoard.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        drawingBoard.rightAnchor.constraint(equalTo: self.inspectorView.leftAnchor).isActive = true
        
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        inspectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        inspectorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        inspectorView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        inspectorView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        topMenuBarView.translatesAutoresizingMaskIntoConstraints = false
        topMenuBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topMenuBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topMenuBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let location = gestureRecognizer.location(in: gestureRecognizer.view)
        self.plane.action.onScreenTapped(Point(x: location.x, y: location.y))
        return true
    }
}
