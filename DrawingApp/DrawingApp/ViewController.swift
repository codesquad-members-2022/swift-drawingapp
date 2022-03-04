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
        guard let rect1 = rectangleFactory.makeRandomRectangle() else {return}
        guard let rect2 = rectangleFactory.makeRandomRectangle() else {return}
        guard let rect3 = rectangleFactory.makeRandomRectangle() else {return}
        guard let rect4 = rectangleFactory.makeRandomRectangle() else {return}
        for rect in [rect1,rect2,rect3,rect4] {
            os_log("\(rect)")
        }
    }
    
    
}

