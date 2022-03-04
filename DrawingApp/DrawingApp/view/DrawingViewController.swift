//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import UIKit
import os

class DrawingViewController: UIViewController {
    private let logger = Logger()
    private lazy var plane = Plane()
    private lazy var rectangleAddButton = RectangleAddButton(frame: CGRect(x: view.center.x - 50, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private var rectangleFactory: RectangleFactory?
    private var targetView: RectangleView?
    private var targetRectangle: Rectangle?
    private var drawingDelegate: DrawingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleAddButton)
        setRectangleButtonEvent()
        rectangleFactory = RectangleFactory(drawingMessage: self)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTappedGesture))
        view.addGestureRecognizer(viewTapGesture)
    }
    
    func setDrawingDelegate(drawingDelegate: DrawingDelegate){
        self.drawingDelegate = drawingDelegate
    }
    
    @objc func viewTappedGesture(){
        self.targetView = nil
        self.targetRectangle = nil
    }
    
    @objc func rectangleTappedGesture(sender: UITapGestureRecognizer){
        self.targetView = sender.view as? RectangleView
        targetRectangle = plane[targetView?.idValue() ?? ""]
        guard let color = targetRectangle?.colorValue() else { return }
        drawingDelegate?.changedColor(rectangleRGB: color)
    }

    private func setRectangleButtonEvent(){
        rectangleAddButton.addTarget(self, action: #selector(rectangleAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func rectangleAddButtonTapped(sender: Any){
        rectangleFactory?.makeRandomRectangle()
    }
    
    private func addRectangleView(rectangle: Rectangle){
        let rectangleView = RectangleView()
        rectangleView.matchProperty(rectangle: rectangle)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rectangleTappedGesture))
        rectangleView.addGestureRecognizer(viewTapGesture)
        view.addSubview(rectangleView)
    }
    
    private func changeViewColorRandomly(){
        rectangleFactory?.makeRandomColor()
    }
    
    private func plusViewAlpha(){
        guard let alpha = targetView?.alpha else { return }
        guard let targetRectangle = self.targetRectangle else { return }
        if alpha < 1.1{
            targetRectangle.changeAlphaValue(alpha: alpha + 0.1)
            targetView?.matchProperty(rectangle: targetRectangle)
        }
    }
    
    private func minusViewAlpha(){
        guard let alpha = targetView?.alpha else { return }
        guard let targetRectangle = self.targetRectangle else { return }
        if alpha > -0.1{
            targetRectangle.changeAlphaValue(alpha: alpha - 0.1)
            targetView?.matchProperty(rectangle: targetRectangle)
        }
    }
}

extension DrawingViewController: RectangleFactoryResponse{
    func setBackgroundColorRandom(rgb: ColorRGB) {
        targetRectangle?.resetColor(rgbValue: rgb)
        guard let targetRectangle = targetRectangle else { return }
        targetView?.matchProperty(rectangle: targetRectangle)
        drawingDelegate?.changedColor(rectangleRGB: targetRectangle.colorValue())
    }
    
    func addRectangleToPlane(rectangle: Rectangle) {
        plane.addRectangle(rectangle: rectangle)
        addRectangleView(rectangle: rectangle)
    }
}
extension DrawingViewController: PropertyDelegate{
    func propertyAction(action: PropertyViewAction) {
        guard let targetView = targetView else { return }
        switch action{
        case .colorChangedTapped:
            changeViewColorRandomly()
        case .alphaPlusTapped:
            plusViewAlpha()
        case .alphaMinusTapped:
            minusViewAlpha()
        }
    }
}
