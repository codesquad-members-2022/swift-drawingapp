//
//  ViewController.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = (Double(self.view.safeAreaLayoutGuide.layoutFrame.size.width), Double(self.view.safeAreaLayoutGuide.layoutFrame.size.height))
        let rectangleFactory = RectangleFactory(screenSize: screenSize)
        let rect1 = rectangleFactory.make()
        let rect2 = rectangleFactory.make()
        let rect3 = rectangleFactory.make()
        let rect4 = rectangleFactory.make()
        
    }


}

