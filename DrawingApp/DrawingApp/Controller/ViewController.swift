//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory = Factory()
        let rects = factory.createRandomRectangles(number: 4)
        
        for i in 0..<rects.count {
            guard let rect = rects[i] else { continue }
            Log.info("\(rect)")
        }
        
    }


}

