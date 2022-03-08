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
        let rectangle1 = factory.createShape(shapeType: .rectangle, point: Point(x: 10, y: 200), size: Size(width: 150, height: 120), color: Color(r: 245, g: 0, b: 245), alpha: Alpha(9))
        let rectangle2 = factory.createShape(shapeType: .rectangle, point: Point(x: 110, y: 180), size: Size(width: 150, height: 120), color: Color(r: 43, g: 124, b: 95), alpha: Alpha(5))
        let rectangle3 = factory.createShape(shapeType: .rectangle, point: Point(x: 590, y: 90), size: Size(width: 150, height: 120), color: Color(r: 98, g: 244, b: 15), alpha: Alpha(7))
        let rectangle4 = factory.createShape(shapeType: .rectangle, point: Point(x: 330, y: 450), size: Size(width: 150, height: 120), color: Color(r: 125, g: 39, b: 99), alpha: Alpha(1))
        logger.info("\(rectangle1 as! Rectangle)")
        logger.info("\(rectangle2 as! Rectangle)")
        logger.info("\(rectangle3 as! Rectangle)")
        logger.info("\(rectangle4 as! Rectangle)")
    }
}
