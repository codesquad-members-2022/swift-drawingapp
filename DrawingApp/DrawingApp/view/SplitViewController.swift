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
        guard let propertyDelegate = drawingViewController as? PropertyDelegate else { return }
        guard let drawingDelegate = propertySetViewController as? DrawingDelegate else{ return }
        propertySetViewController.setPropertyDelegate(propertyAction: propertyDelegate)
        drawingViewController.setDrawingDelegate(drawingDelegate: drawingDelegate)
        viewControllers = [propertySetViewController, drawingViewController]
    }
}
