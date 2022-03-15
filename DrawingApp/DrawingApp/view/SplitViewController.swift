//
//  SplitViewController.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/03.
//

import Foundation
import UIKit

class SplitViewController: UISplitViewController{
    private lazy var drawingViewController = storyboard?.instantiateViewController(withIdentifier: "DrawingViewController") as? DrawingViewController
    private lazy var propertySetViewController = storyboard?.instantiateViewController(withIdentifier: "PropertySetViewController") as? PropertySetViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let propertySetViewController = propertySetViewController else { return }
        guard let drawingViewController = drawingViewController else{ return }
        propertySetViewController.setPropertyDelegate(propertyAction: self)
        drawingViewController.setDrawingDelegate(drawingDelegate: self)
        drawingViewController.setRectangleChangeable(plane: Plane(rectangleFactory: CustomViewFactory()))
        viewControllers = [propertySetViewController, drawingViewController]
    }
    
    enum Notification{
        enum Event{
            static let propertyAction = Foundation.Notification.Name.init("propertyAction")
            static let changedColorText = Foundation.Notification.Name.init("changedColorText")
            static let alphaButtonHidden = Foundation.Notification.Name.init("alphaButtonHidden")
            static let updateSelectedRectangleUI = Foundation.Notification.Name.init("updateSelectedUI")
            static let updateSelectedPhotoUI = Foundation.Notification.Name.init("updateSelectedPhotoUI")
            static let updateDeselectedUI = Foundation.Notification.Name.init("updateDeselectedUI")
        }
        enum Key{
            case rectangle
            case action
            case customViewEntity
            case photo
        }
    }
}
extension SplitViewController: DrawingDelegate{
    func drawingViewDidSelectedPhoto(photo: Photo) {
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.updateSelectedPhotoUI, object: self, userInfo: [SplitViewController.Notification.Key.photo : photo])
    }
    
    func drawingViewDidDeselect() {
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.updateDeselectedUI, object: self)
    }
    
    func drawingViewDidSelecteRectangle(rectangle: Rectangle) {
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.updateSelectedRectangleUI, object: self, userInfo: [SplitViewController.Notification.Key.rectangle : rectangle])
    }
    
    func drawingViewDidUpdateAlpha(customModel: CustomViewEntity) {
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.alphaButtonHidden, object: self, userInfo: [SplitViewController.Notification.Key.customViewEntity : customModel])
    }
    
    func drawingViewDidChangeColor(rectangle: Rectangle) {
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.changedColorText, object: self, userInfo: [SplitViewController.Notification.Key.rectangle : rectangle])
    }
}
extension SplitViewController: PropertyDelegate{
    func propertyViewAction(action: PropertyViewAction) {
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.propertyAction, object: self, userInfo: [SplitViewController.Notification.Key.action : action])
    }
}
