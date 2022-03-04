//
//  ViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import UIKit

class ViewController: UIViewController, PlaneOutput {
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
        layout()
        
        inspectorView.delegate = self
        topMenuBarView.delegate = self
        plane.delegate = self
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.drawingBoard.addGestureRecognizer(tapGesture)
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
    
    func didDisSelectedRectangle(to id: String) {
        self.rectangleViews[id]?.selected(is: false)
        self.inspectorView.isHidden = true
    }
    
    func didSelectedRectangle(to rectangle: Rectangle) {
        self.inspectorView.isHidden = false
        self.inspectorView.update(rectangle: rectangle)
        self.rectangleViews[rectangle.id]?.selected(is: true)
    }
    
    func draw(to rectangle: Rectangle) {
        let drawView = DrawingViewFactory.make(to: rectangle)
        self.drawingBoard.addSubview(drawView)
        self.rectangleViews[rectangle.id] = drawView
    }
    
    func update(to id: String, color: Color) {
        self.rectangleViews[id]?.update(color: color)
        self.inspectorView.update(color: color)
    }
    
    func update(to id: String, point: Point) {
        self.rectangleViews[id]?.update(point: point)
    }
    
    func update(to id: String, size: Size) {
        self.rectangleViews[id]?.update(size: size)
    }
    
    func update(to id: String, alpha: Alpha) {
        self.rectangleViews[id]?.update(alpha: alpha)
        self.inspectorView.update(alpha: alpha)
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
