//
//  ViewController.swift
//  DrawingApp
//
//  Created by 허태양 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    let idElement: String = "abcdefghijklmnopqrstuvwxyz0123456789"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s = createSquare(Size(100, 100), Point(400, 500), 128, 128, 128, 5)
        print(s)
    }
    
    func createSquare(_ size: Size, _ point: Point, _ r: Int, _ g: Int, _ b: Int, _ a: Int) -> Square {
        var id = String((0 ..< 9).map{ _ in idElement.randomElement()! })
        id.insert("-", at: id.index(id.startIndex, offsetBy: 3))
        id.insert("-", at: id.index(id.startIndex, offsetBy: 7))
        return Square(id, Size(100, 100), Point(400, 500), 128, 128, 128, 5)
    }

}
