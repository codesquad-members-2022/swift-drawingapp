//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import UIKit
import os

class DrawingViewController: UIViewController{
    private let logger = Logger()
    private var plane: RectangleChangeable?
    private lazy var rectangleAddButton = RectangleAddButton(frame: CGRect(x: view.center.x - 100, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private lazy var imageAddButton = ImageAddButton(frame: CGRect(x: view.center.x, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private var drawingDelegate: DrawingDelegate?
    private var rectangleViews: [String: RectangleView] = [:]
    
    private let notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleAddButton)
        view.addSubview(imageAddButton)
        setRectangleButtonEvent()
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTappedGesture))
        view.addGestureRecognizer(viewTapGesture)
        addNotificationObserver()
    }
    
    func setDrawingDelegate(drawingDelegate: DrawingDelegate){
        self.drawingDelegate = drawingDelegate
    }
    
    func setRectangleChangeable(plane: RectangleChangeable){
        self.plane = plane
    }
    
    private func addNotificationObserver(){
        notificationCenter.addObserver(self, selector: #selector(addRectangleView), name: Plane.NotiEvent.addedRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(rectangleColorChanged), name: Plane.NotiEvent.changedRectangleColor, object: plane)
        notificationCenter.addObserver(self, selector: #selector(selectedRectangle), name: Plane.NotiEvent.selectedRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(deSelectedRectangle), name: Plane.NotiEvent.deselectedRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(rectangleAlphaChanged), name: Plane.NotiEvent.updateRectangleAlpha, object: plane)
        notificationCenter.addObserver(self, selector: #selector(propertyAction), name: SplitViewController.NotiEvent.propertyAction, object: nil)
    }
    
    @objc private func viewTappedGesture(){
        plane?.deSelectTargetRectangle()
    }
    
    @objc private func deSelectedRectangle(_ notification: Notification){
        drawingDelegate?.drawingViewDidDeselect()
    }
    
    private func setRectangleButtonEvent(){
        rectangleAddButton.addTarget(self, action: #selector(rectangleAddButtonTapped), for: .touchUpInside)
        imageAddButton.addTarget(self, action: #selector(imageAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func rectangleAddButtonTapped(sender: Any){
        plane?.addRandomRectangle()
    }
    
    @objc func imageAddButtonTapped(sender: Any){
        // add action when imagebutton Tapped
    }
    
    @objc private func addRectangleView(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.NotificationKey.rectangle] as? Rectangle else {
            return
        }
        let rectangleView = RectangleView(size: rectangle.size, point: rectangle.point)
        rectangleView.setRGBColor(rgb: rectangle.color)
        rectangleView.setAlpha(alpha: rectangle.alpha)
        drawingDelegate?.drawingViewDidChangeColor(rectangle: rectangle)
        drawingDelegate?.drawingViewDidUpdateAlpha(rectangle: rectangle)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rectangleTappedGesture))
        rectangleView.addGestureRecognizer(viewTapGesture)
        rectangleViews[rectangle.uniqueId] = rectangleView
        view.addSubview(rectangleView)
    }
    
    @objc func rectangleTappedGesture(sender: UITapGestureRecognizer){
        guard let touchedView = sender.view as? RectangleView else { return }
        let point = ViewPoint(x: Int(touchedView.frame.origin.x), y: Int(touchedView.frame.origin.y))
        plane?.selectTargetRectangle(point: point)
    }
    
    @objc private func selectedRectangle(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.NotificationKey.rectangle] as? Rectangle else {
            return
        }
        drawingDelegate?.drawingViewDidSelecteRectangle(rectangle: rectangle)
    }
    
    @objc private func rectangleColorChanged(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.NotificationKey.rectangle] as? Rectangle else {
            return
        }
        rectangleViews[rectangle.uniqueId]?.setRGBColor(rgb: rectangle.color)
        drawingDelegate?.drawingViewDidChangeColor(rectangle: rectangle)
    }
    
    @objc private func rectangleAlphaChanged(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.NotificationKey.rectangle] as? Rectangle else {
            return
        }
        rectangleViews[rectangle.uniqueId]?.setAlpha(alpha: rectangle.alpha)
        drawingDelegate?.drawingViewDidUpdateAlpha(rectangle: rectangle)
    }
    
    private func plusViewAlpha(){
        plane?.pluseRectangleAlpha()
    }
    
    private func minusViewAlpha(){
        plane?.minusRectangleAlpha()
    }
    
    @objc private func propertyAction(_ notification: Notification) {
        guard let action = notification.userInfo?[PropertyNotificationKey.action] as? PropertyViewAction else { return }
        switch action{
        case .colorChangedTapped:
            plane?.changeRectangleRandomColor()
        case .alphaPlusTapped:
            plusViewAlpha()
        case .alphaMinusTapped:
            minusViewAlpha()
        }
    }
}
