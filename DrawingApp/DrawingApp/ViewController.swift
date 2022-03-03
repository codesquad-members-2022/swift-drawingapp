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

            

        
        for _ in 0..<4 {
            
            let id = IDFactory.makeRandomID()
            let size = SizeFactory.makeRandomSize()
            let point = PointFactory.makeRandomPoint()
            let rgb = RGBFactory.makeRandomRGB()
            let alpha = AlphaFactory.makeRandomAlpha()
            
            
            let rect = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
            
            os_log(.default, "\(rect)")
        }
    }
}

