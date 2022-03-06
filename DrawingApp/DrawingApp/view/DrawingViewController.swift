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
    private var drawingDelegate: DrawingDelegate?
    private var rectangleViews: [String: RectangleView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleAddButton)
        setRectangleButtonEvent()
        plane.setDelegate(planeDelegate: self)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTappedGesture))
        view.addGestureRecognizer(viewTapGesture)
    }
    
    func setDrawingDelegate(drawingDelegate: DrawingDelegate){
        self.drawingDelegate = drawingDelegate
    }
    
    @objc func viewTappedGesture(){
        plane.deselectedRectangle()
    }
    
    @objc func rectangleTappedGesture(sender: UITapGestureRecognizer){
        guard let touchedView = sender.view as? RectangleView else { return }
        let point = ViewPoint(x: Int(touchedView.frame.origin.x), y: Int(touchedView.frame.origin.y))
        plane.selectedRectangle(point: point)
    }
    
    private func setRectangleButtonEvent(){
        rectangleAddButton.addTarget(self, action: #selector(rectangleAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func rectangleAddButtonTapped(sender: Any){
        plane.addRectangle()
    }
    
    private func addRectangleView(rectangle: Rectangle){
        let rectangleView = RectangleView(size: rectangle.size, point: rectangle.point)
        rectangleView.setRGBColor(rgb: rectangle.color)
        rectangleView.setAlpha(alpha: rectangle.alpha)
        drawingDelegate?.changedColor(rectangleRGB: rectangle.color)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rectangleTappedGesture))
        rectangleView.addGestureRecognizer(viewTapGesture)
        rectangleViews[rectangle.uniqueId] = rectangleView
        view.addSubview(rectangleView)
    }
    
    private func changeViewColorRandomly(){
        plane.changeColor()
    }
    
    private func plusViewAlpha(){
        plane.plusAlpha()
    }
    
    private func minusViewAlpha(){
        plane.minusAlpha()
    }
    
    func propertyAction(action: PropertyViewAction) {
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
extension DrawingViewController: PlaneDelegate{
    func didAddRandomRectangle(rectangle: Rectangle) {
        addRectangleView(rectangle: rectangle)
    }
    
    func didUpdateAlpha(id: String, alpha: Double) {
        guard let rectangleView = rectangleViews[id] else { return }
        rectangleView.setAlpha(alpha: alpha)
        drawingDelegate?.updatedAlpha(alpha: alpha)
    }
    
    func deSelectedTarget() {
        drawingDelegate?.deselected()
    }
    
    func didSelectedTarget(id: String, alpha: Double, colorRGB: ColorRGB) {
        drawingDelegate?.defaultProperty(alpha: alpha, rectangleRGB: colorRGB)
        drawingDelegate?.changedColor(rectangleRGB: colorRGB)
    }
    
    func didChangedColor(id: String, colorRGB: ColorRGB) {
        let rectangleView = rectangleViews[id]
        rectangleView?.setRGBColor(rgb: colorRGB)
        drawingDelegate?.changedColor(rectangleRGB: colorRGB)
    }
}
