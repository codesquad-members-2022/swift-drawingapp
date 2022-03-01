//
//  ViewController.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let id = RandomFactory.makeRandomID()
        let origin = RandomFactory.makeRandomPoint()
        let size = Size(width: 150, height: 120)
        let alpha = RandomFactory.makeRandomAlpha()
        let rgb = RandomFactory.makeRandomRGB()
        
        let rectangle = RectangleFactory.makeRectangleAtRandomPoint(
            id: id,
            origin: origin,
            size: size,
            backGroundColor: rgb,
            alpha:alpha
        )
        
        os_log("\(rectangle)")
        
    }
}

