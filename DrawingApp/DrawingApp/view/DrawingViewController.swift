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
    private var plane: PlaneDelegate?
    private lazy var rectangleAddButton = RectangleAddButton(frame: CGRect(x: view.center.x - 50, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private var drawingDelegate: DrawingDelegate?
    private var rectangleViews: [String: RectangleView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleAddButton)
        setRectangleButtonEvent()
        plane = Plane()
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTappedGesture))
        view.addGestureRecognizer(viewTapGesture)
    }
    
    func setDrawingDelegate(drawingDelegate: DrawingDelegate){
        self.drawingDelegate = drawingDelegate
    }
    
    @objc func viewTappedGesture(){
        plane?.deSelectedTarget()
    }
    
    @objc func rectangleTappedGesture(sender: UITapGestureRecognizer){
        guard let touchedView = sender.view as? RectangleView else { return }
        let point = ViewPoint(x: Int(touchedView.frame.origin.x), y: Int(touchedView.frame.origin.y))
        guard let rectangle = plane?.didSelectedTarget(point: point) else { return }
        drawingDelegate?.defaultProperty(alpha: rectangle.alpha, rectangleRGB: rectangle.color)
    }
    
    private func setRectangleButtonEvent(){
        rectangleAddButton.addTarget(self, action: #selector(rectangleAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func rectangleAddButtonTapped(sender: Any){
        guard let rectangle = plane?.didAddRandomRectangle() else { return }
        addRectangleView(rectangle: rectangle)
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
        guard let rectangle = plane?.didChangedColor() else { return }
        rectangleViews[rectangle.uniqueId]?.setRGBColor(rgb: rectangle.color)
        drawingDelegate?.changedColor(rectangleRGB: rectangle.color)
    }
    
    private func plusViewAlpha(){
        guard let rectangle = plane?.didUpdateAlpha(changed: .plus) else { return }
        rectangleViews[rectangle.uniqueId]?.setAlpha(alpha: rectangle.alpha)
        drawingDelegate?.updatedAlpha(alpha: rectangle.alpha)
    }
    
    private func minusViewAlpha(){
        guard let rectangle = plane?.didUpdateAlpha(changed: .minus) else { return }
        rectangleViews[rectangle.uniqueId]?.setAlpha(alpha: rectangle.alpha)
        drawingDelegate?.updatedAlpha(alpha: rectangle.alpha)
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
