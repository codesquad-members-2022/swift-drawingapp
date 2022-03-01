//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shapeFactory = ShapeFactory()
        
        (0..<4).forEach { _ in
            let Rect = shapeFactory.createShape(shapeType: .Rectangle)
        }
    }
}

