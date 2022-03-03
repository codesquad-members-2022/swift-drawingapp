//
//  ViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    let drawingBoard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var squareViews: [String:SquareView] = [:]
    
    let topMenuBarView: TopMenuBarView = {
        let topMenuBarView = TopMenuBarView()
        topMenuBarView.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        topMenuBarView.layer.cornerRadius = 5
        topMenuBarView.translatesAutoresizingMaskIntoConstraints = false
        return topMenuBarView
    }()
    
    let inspectorView: InspectorView = {
        let inspectorView = InspectorView()
        inspectorView.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        return inspectorView
    }()
    
    let plane = Plane()
    let drawingViewFactory = DrawingViewFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        layout()
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.drawingBoard.addGestureRecognizer(tapGesture)
    }
    
    func bind() {
//        topMenuBarView.bind(plane: self.plane)
//        inspectorView.bind(plane: self.plane)
        
        plane.state.drawSquare = { square in
            let drawView = self.drawingViewFactory.make(square: square)
            self.drawingBoard.addSubview(drawView.view)
            self.squareViews[square.id] = drawView
        }
        
        plane.state.didDisSelectedSquare = { square in
            guard let square = square else {
                return
            }
            self.squareViews[square.id]?.selected(is: false)
        }
        
        plane.state.didSelectedSquare = { square in
            self.inspectorView.updateInspector(in: square)
            
            guard let square = square else {
                return
            }
            self.squareViews[square.id]?.selected(is: true)
        }
        
        plane.state.updateSquare = { square in
            self.squareViews[square.id]?.update(in: square)
            self.inspectorView.updateInspector(in: square)
        }
    }
    
    func layout() {
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(drawingBoard)
        self.view.addSubview(inspectorView)
        self.view.addSubview(topMenuBarView)
        
        drawingBoard.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        drawingBoard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        drawingBoard.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        drawingBoard.rightAnchor.constraint(equalTo: self.inspectorView.leftAnchor).isActive = true
        
        inspectorView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        inspectorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        inspectorView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        inspectorView.widthAnchor.constraint(equalTo: safeAreaGuide.widthAnchor, multiplier: 0.25).isActive = true
        
        topMenuBarView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topMenuBarView.centerXAnchor.constraint(equalTo: self.drawingBoard.centerXAnchor).isActive = true
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
