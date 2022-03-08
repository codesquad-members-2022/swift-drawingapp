//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory = RectangleFactory()
        let rectangle = factory.createRectangle()
        var plane = Plane()
        plane.rectangleDidCreated(rectangle: rectangle)
    }
}
