//
//  ViewController.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/02.
//

import UIKit
import os

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory = RectangleFactory()
        let rect1 = factory.createRandomRectangle()
        let rect2 = factory.createRectangle(x: 100, y: 150, width: 300.0, height: 300.0)
        
        let log = Logger()
        log.info("Rect1 : \(rect1)")
        log.info("Rect2 : \(rect2)")
    }
}

