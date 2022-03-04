//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let factory = ShapeFactory()
        let rectangle = factory.createShape(shapeType: .rectangle, size: Size(width: 10, height: 10), point: Point(x: 10, y: 10), color: BackgroundColor(R: 0, G: 0, B: 0), alpha: 10)
    }


}

