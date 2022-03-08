//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    let logger = Logger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let factory = ShapeFactory()
        let rectangle1 = factory.createShape(shapeType: .rectangle, point: Point(x: 10, y: 200), size: Size(width: 150, height: 120), color: BackgroundColor(R: 245, G: 0, B: 245), alpha: 9)
        let rectangle2 = factory.createShape(shapeType: .rectangle, point: Point(x: 110, y: 180), size: Size(width: 150, height: 120), color: BackgroundColor(R: 43, G: 124, B: 95), alpha: 5)
        let rectangle3 = factory.createShape(shapeType: .rectangle, point: Point(x: 590, y: 90), size: Size(width: 150, height: 120), color: BackgroundColor(R: 98, G: 244, B: 15), alpha: 7)
        let rectangle4 = factory.createShape(shapeType: .rectangle, point: Point(x: 330, y: 450), size: Size(width: 150, height: 120), color: BackgroundColor(R: 125, G: 39, B: 99), alpha: 1)
        logger.info("\(rectangle1 as! Rectangle)")
        logger.info("\(rectangle2 as! Rectangle)")
        logger.info("\(rectangle3 as! Rectangle)")
        logger.info("\(rectangle4 as! Rectangle)")
    }


}

