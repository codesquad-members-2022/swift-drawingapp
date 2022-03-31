//
//  ViewController.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/17.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomRectFactory = RectFactory()
        
        (0..<4).forEach { _ in
            let Rect = randomRectFactory.createRandomRect()
            os_log(.debug, log: .default, "\n\(Rect.description)")
        }
    }
    
}

