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
        drawingViewController.setRectangleChangeable(plane: Plane(rectangleFactory: RectangleFactory()))
        viewControllers = [propertySetViewController, drawingViewController]
    }
    
    enum NotiEvent{
        static let propertyAction = Notification.Name.init("propertyAction")
        static let changedColorText = Notification.Name.init("changedColorText")
        static let alphaButtonHidden = Notification.Name.init("alphaButtonHidden")
        static let updateSelectedUI = Notification.Name.init("updateSelectedUI")
        static let updateDeselectedUI = Notification.Name.init("updateDeselectedUI")
    }
}
extension SplitViewController: DrawingDelegate{
    func deselected() {
        NotificationCenter.default.post(name: SplitViewController.NotiEvent.updateDeselectedUI, object: self)
    }
    
    func selectedRectangle(rectangle: Rectangle) {
        NotificationCenter.default.post(name: SplitViewController.NotiEvent.updateSelectedUI, object: self, userInfo: [PropertyNotificationKey.rectangle : rectangle])
    }
    
    func updatedAlpha(rectangle: Rectangle) {
        NotificationCenter.default.post(name: SplitViewController.NotiEvent.alphaButtonHidden, object: self, userInfo: [PropertyNotificationKey.rectangle : rectangle])
    }
    
    func changedColor(rectangle: Rectangle) {
        NotificationCenter.default.post(name: SplitViewController.NotiEvent.changedColorText, object: self, userInfo: [PropertyNotificationKey.rectangle : rectangle])
    }
}
extension SplitViewController: PropertyDelegate{
    func propertyAction(action: PropertyViewAction) {
        NotificationCenter.default.post(name: SplitViewController.NotiEvent.propertyAction, object: self, userInfo: [PropertyNotificationKey.action : action])
    }
}

enum PropertyNotificationKey{
    case rectangle
    case action
}
