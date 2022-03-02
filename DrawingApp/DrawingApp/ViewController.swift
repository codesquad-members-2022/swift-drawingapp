//
//  ViewController.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect1 = Rectangle(uid: "1111", point: Rectangle.Point(x:10, y:200), size: Rectangle.Size(width: 150, height: 120), color: Color(red: 245, green: 0, blue: 245), alpha: 9)
        print("Rect1", rect1)
        
        let rect2 = RectangleFactory.make(origin: Rectangle.Point(x: 0, y: 0), size: Rectangle.Size(width: 100, height: 100))
        print("Rect2", rect2)
    }
}
