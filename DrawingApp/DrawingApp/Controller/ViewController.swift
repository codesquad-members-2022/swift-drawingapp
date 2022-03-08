//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    var delegate: RectangleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let factory = RectangleFactory()
        for _ in 0..<4 {
            let rectangle = factory.createRectangle()
            delegate?.rectangleDidCreated(rectangle: rectangle)
        }
    }
}


protocol RectangleDelegate {
    func rectangleDidCreated(rectangle: Rectangle)
}
