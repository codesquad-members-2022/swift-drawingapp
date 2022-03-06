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
    
    var rectangleViews: [String:RectangleView] = [:]
    
    let topMenuBarView: TopMenuBarView = {
        let topMenuBarView = TopMenuBarView()
        topMenuBarView.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        topMenuBarView.layer.cornerRadius = 5
        topMenuBarView.translatesAutoresizingMaskIntoConstraints = false
        return topMenuBarView
    }()
    
    let inspectorView: InspectorView = {
        let inspectorView = InspectorView()
        inspectorView.isHidden = true
        inspectorView.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        inspectorView.translatesAutoresizingMaskIntoConstraints = false
        return inspectorView
    }()
    
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        layout()
        
        inspectorView.delegate = self
        topMenuBarView.delegate = self
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.drawingBoard.addGestureRecognizer(tapGesture)
    }
    
    func bind() {
        NotificationCenter.default.addObserver(forName: Plane.EventName.didDisSelectedRectangle, object: nil, queue: nil) { notification in
            guard let id = notification.object as? String else {
                return
            }
            self.inspectorView.isHidden = true
            self.rectangleViews[id]?.selected(is: false)
        }
        
        NotificationCenter.default.addObserver(forName: Plane.EventName.didSelectedRectangle, object: nil, queue: nil) { notification in
            guard let rectangle = notification.userInfo?["rectangle"] as? Rectangle else {
                return
            }
            self.inspectorView.isHidden = false
            self.inspectorView.update(rectangle: rectangle)
            self.rectangleViews[rectangle.id]?.selected(is: true)
        }
                
        NotificationCenter.default.addObserver(forName: Plane.EventName.makeRectangle, object: nil, queue: nil) { notification in
            guard let rectangle = notification.userInfo?["rectangle"] as? Rectangle else {
                return
            }
            let drawView = DrawingViewFactory.make(rectangle: rectangle)
            self.drawingBoard.addSubview(drawView)
            self.rectangleViews[rectangle.id] = drawView
        }
        
        NotificationCenter.default.addObserver(forName: Rectangle.EventName.updateColor, object: nil, queue: nil) { notification in
            guard let rectangle = notification.object as? Rectangle,
            let color = notification.userInfo?["color"] as? Color else {
                return
            }
            self.rectangleViews[rectangle.id]?.update(color: color)
            self.inspectorView.update(color: color)
        }
        
        NotificationCenter.default.addObserver(forName: Rectangle.EventName.updateAlpha, object: nil, queue: nil) { notification in
            guard let rectangle = notification.object as? Rectangle,
            let alpha = notification.userInfo?["alpha"] as? Alpha else {
                return
            }
            self.rectangleViews[rectangle.id]?.update(alpha: alpha)
            self.inspectorView.update(alpha: alpha)
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
        drawingBoard.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
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
        self.plane.touchPoint(where: Point(x: location.x, y: location.y))
        return true
    }
}

extension ViewController: InspectorDelegate {
    func changeColorButtonTapped() {
        self.plane.colorChanged()
    }
    
    func alphaSliderValueChanged(alpha: Alpha) {
        self.plane.alphaChanged(alpha: alpha)
    }
}

extension ViewController: TopMenuBarDelegate {
    func makeRectangleButtonTapped() {
        self.plane.makeRectangle()
    }
}
