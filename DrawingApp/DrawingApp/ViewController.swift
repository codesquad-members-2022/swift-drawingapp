//
//  ViewController.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = (Double(self.view.safeAreaLayoutGuide.layoutFrame.size.width), Double(self.view.safeAreaLayoutGuide.layoutFrame.size.height))
        let rectangleFactory = RectangleFactory(screenSize: screenSize)
        let rect1 = rectangleFactory.makeRandomRectangle()
        let rect2 = rectangleFactory.makeRandomRectangle()
        let rect3 = rectangleFactory.makeRandomRectangle()
        let rect4 = rectangleFactory.makeRandomRectangle()
        for rect in [rect1,rect2,rect3,rect4] {
            os_log("\(rect)")
        }
    }


}

