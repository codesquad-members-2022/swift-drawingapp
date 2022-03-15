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
            squareAry.append(createSquare(size: Size(width: Double(i * 100), height: Double(i * 200)), point: Point(X: Double(i * 300), Y: Double(i * 400)), r: i + 10, g: i + 20, b: i + 30, a: 2 * i + 1))
        }
        
        for i in 0..<4 {
            os_log("Rect%@ %@", "\(i)", "\(squareAry[i])")
        }
    }
    
    func createSquare(size: Size, point: Point, r: Int, g: Int, b: Int, a: Int) -> Square {
        var id = String((0 ..< 9).map{ _ in idElement.randomElement()! })
        id.insert("-", at: id.index(id.startIndex, offsetBy: 3))
        id.insert("-", at: id.index(id.startIndex, offsetBy: 7))
        return Square(id: id, size: size, point: point, r: r, g: g, b: b, alpha: a)
    }

}
