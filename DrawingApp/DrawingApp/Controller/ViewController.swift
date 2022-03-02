//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit
import os


class ViewController: UIViewController {
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<4 {
            let rect = ShapeFactory.makeRandomRectangle()
            os_log(.default, "Rect \(i+1): \(rect)")
        }
    }
}
