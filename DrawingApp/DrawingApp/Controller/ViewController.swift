//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory = Factory()
        if let rect = factory.createRandomSquare() {
            print("rect1: \(rect)")
            
        }
    }


}

