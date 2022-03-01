//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = ShapeFactory.makeRectangle()
        print(rect)
    }
}

