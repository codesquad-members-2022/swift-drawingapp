//
//  ViewController.swift
//  DrawingApp
//
//  Created by 허태양 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    let idElement: String = "abcdefghijklmnopqrstuvwxyz0123456789"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var squareAry : [Square] = []
        
        for i in 1..<5 {
            squareAry.append(createSquare(Size(Double(i * 100), Double(i * 200)), Point(Double(i * 300), Double(i * 400)), i + 10, i + 20, i + 30, 2 * i + 1))
        }
        
        for i in 0..<4 {
            os_log("Rect%@ %@", "\(i)", "\(squareAry[i])")
        }
    }
    
    func createSquare(_ size: Size, _ point: Point, _ r: Int, _ g: Int, _ b: Int, _ a: Int) -> Square {
        var id = String((0 ..< 9).map{ _ in idElement.randomElement()! })
        id.insert("-", at: id.index(id.startIndex, offsetBy: 3))
        id.insert("-", at: id.index(id.startIndex, offsetBy: 7))
        return Square(id, size, point, r, g, b, a)
    }

}
