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
        viewControllers = [propertySetViewController, drawingViewController]
    }
}
extension SplitViewController: DrawingDelegate{
    func deselected() {
        NotificationCenter.default.post(name: .updateDeselectedUI, object: nil)
    }
    
    func defaultProperty(rectangle: Rectangle) {
        NotificationCenter.default.post(name: .updateSelectedUI, object: rectangle)
    }
    
    func updatedAlpha(alpha: Double) {
        NotificationCenter.default.post(name: .alphaButtonHidden, object: alpha)
    }
    
    func changedColor(rectangleRGB: ColorRGB) {
        NotificationCenter.default.post(name: .changedColorText, object: rectangleRGB)
    }
}
extension SplitViewController: PropertyDelegate{
    func propertyAction(action: PropertyViewAction) {
        NotificationCenter.default.post(name: .propertyAction, object: action)
    }
}
