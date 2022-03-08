//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    var delegate: PlaneDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plane = Plane()
        let factory = RectangleFactory()
        for _ in 0..<4 {
            let rectangle = factory.createRectangle()
            delegate?.rectangleDidCreated(rectangle: rectangle)
        }
        print(plane)
    }
}


protocol PlaneDelegate {
    mutating func rectangleDidCreated(rectangle: Rectangle)
}
