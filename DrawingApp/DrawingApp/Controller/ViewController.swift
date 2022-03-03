//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomRectangleFactory = RandomRectangleFactory()

        (0..<4).forEach { _ in
            let Rect = randomRectangleFactory.createRandomShape()
            os_log(.debug, log: .default, "\n\(Rect.description)")
        }
    }
}

