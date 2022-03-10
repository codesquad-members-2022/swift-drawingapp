//
//  ViewController.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/02.
//

import UIKit
import os

class ViewController: UIViewController {

    var plane = Plane()
    let factory = RectangleFactory()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addRectangleButtonTouched(_ sender: Any) {
        plane.add(rectangle: factory.createRandomRectangle())
    }
}

