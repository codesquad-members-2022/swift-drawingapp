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
    
    private let notificationCenter = NotificationCenter.default
    private var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleAddButton)
        setRectangleButtonEvent()
        plane = Plane()
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTappedGesture))
        view.addGestureRecognizer(viewTapGesture)
        addNotificationObserver()
    }
    
    func setDrawingDelegate(drawingDelegate: DrawingDelegate){
        self.drawingDelegate = drawingDelegate
    }
    
    private func addNotificationObserver(){
        notificationCenter.addObserver(self, selector: #selector(addRectangleView), name: .addedRectangle, object: nil)
        notificationCenter.addObserver(self, selector: #selector(changeViewColorRandomly), name: .changedRectangleColor, object: nil)
        notificationCenter.addObserver(self, selector: #selector(touchedRectangleView), name: .selectedRectangle, object: nil)
        notificationCenter.addObserver(self, selector: #selector(deSelectedRectangle), name: .deselectedRectangle, object: nil)
        notificationCenter.addObserver(self, selector: #selector(updateRectangleAlpha), name: .updateRectangleAlpha, object: nil)
    }
    
    @objc private func viewTappedGesture(){
        plane?.deSelectedTarget()
    }
    
    @objc private func deSelectedRectangle(_ notification: Notification){
        drawingDelegate?.deselected()
    }
    
    private func setRectangleButtonEvent(){
        rectangleAddButton.addTarget(self, action: #selector(rectangleAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func rectangleAddButtonTapped(sender: Any){
        plane?.didAddRandomRectangle()
    }
    
    @objc private func addRectangleView(_ notification: Notification){
        guard let rectangle = notification.object as? Rectangle else {
            return
        }
        let rectangleView = RectangleView(size: rectangle.size, point: rectangle.point)
        rectangleView.setRGBColor(rgb: rectangle.color)
        rectangleView.setAlpha(alpha: rectangle.alpha)
        drawingDelegate?.changedColor(rectangleRGB: rectangle.color)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rectangleTappedGesture))
        rectangleView.addGestureRecognizer(viewTapGesture)
        rectangleViews[rectangle.uniqueId] = rectangleView
        view.addSubview(rectangleView)
    }
    
    @objc func rectangleTappedGesture(sender: UITapGestureRecognizer){
        guard let touchedView = sender.view as? RectangleView else { return }
        let point = ViewPoint(x: Int(touchedView.frame.origin.x), y: Int(touchedView.frame.origin.y))
        plane?.didSelectedTarget(point: point)
    }
    
    @objc private func touchedRectangleView(_ notification: Notification){
        guard let rectangle = notification.object as? Rectangle else { return }
        drawingDelegate?.defaultProperty(alpha: rectangle.alpha, rectangleRGB: rectangle.color)
    }
    
    @objc private func changeViewColorRandomly(_ notification: Notification){
        guard let rectangle = notification.object as? Rectangle else { return }
        rectangleViews[rectangle.uniqueId]?.setRGBColor(rgb: rectangle.color)
        drawingDelegate?.changedColor(rectangleRGB: rectangle.color)
    }
    
    @objc private func updateRectangleAlpha(_ notification: Notification){
        guard let rectangle = notification.object as? Rectangle else { return }
        rectangleViews[rectangle.uniqueId]?.setAlpha(alpha: rectangle.alpha)
        drawingDelegate?.updatedAlpha(alpha: rectangle.alpha)
    }
    
    private func plusViewAlpha(){
        plane?.didUpdateAlpha(changed: .plus)
    }
    
    private func minusViewAlpha(){
        plane?.didUpdateAlpha(changed: .minus)
    }
    
    func propertyAction(action: PropertyViewAction) {
        switch action{
        case .colorChangedTapped:
            plane?.didChangedColor()
        case .alphaPlusTapped:
            plusViewAlpha()
        case .alphaMinusTapped:
            minusViewAlpha()
        }
    }
}

extension Notification.Name{
    static let addedRectangle = Notification.Name.init("addedRectangle")
    static let selectedRectangle = Notification.Name.init("selectedRectangle")
    static let deselectedRectangle = Notification.Name.init("deselectedRectangle")
    static let changedRectangleColor = Notification.Name.init("changedRectangleColor")
    static let updateRectangleAlpha = Notification.Name.init("updateRectangleAlpha")
}

