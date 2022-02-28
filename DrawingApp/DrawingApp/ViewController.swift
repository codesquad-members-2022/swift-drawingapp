//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentScreenSize = (width: Double(self.view.safeAreaLayoutGuide.layoutFrame.width),
                                 height: Double(self.view.safeAreaLayoutGuide.layoutFrame.height))
        let factory = RectangleFactory(screenSize: currentScreenSize)
        let rect1 = factory.generateRectangle()
        let rect2 = factory.generateRectangle()
        let rect3 = factory.generateRectangle()
        let rect4 = factory.generateRectangle()
        
        let message = "Rect1: \(rect1)\nRect2: \(rect2)\nRect3: \(rect3)\nRect4: \(rect4)"
        os_log("%@", message)
    }


}

