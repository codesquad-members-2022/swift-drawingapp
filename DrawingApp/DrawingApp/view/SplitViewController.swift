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
        propertySetViewController?.updateDeselectedUI()
    }
    
    func defaultProperty(alpha: Double, rectangleRGB: ColorRGB) {
        propertySetViewController?.updateSelectedUI(alpha: alpha, rectangleRGB: rectangleRGB)
    }
    
    func updatedAlpha(alpha: Double) {
        propertySetViewController?.alphaButtonIsHidden(alpha: alpha)
    }
    
    func changedColor(rectangleRGB: ColorRGB) {
        propertySetViewController?.changedColor(rectangleRGB: rectangleRGB)
    }
}
extension SplitViewController: PropertyDelegate{
    func propertyAction(action: PropertyViewAction) {
        drawingViewController?.propertyAction(action: action)
    }
}
