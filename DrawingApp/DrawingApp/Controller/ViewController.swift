//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit
import os

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory = RectangleFactory()
        
        let rect1 = factory.createRectangle()
        let rect2 = factory.createRectangle()
        let rect3 = factory.createRectangle()
        let rect4 = factory.createRectangle()
        
        let rectList = [rect1, rect2, rect3, rect4]
        let log = Logger()
        for rectangle in rectList {
            log.info("Rect: \(rectangle)")
        }
    }
}

