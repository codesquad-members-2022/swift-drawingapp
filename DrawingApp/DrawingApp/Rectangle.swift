//
//  Rectangle.swift
//  DrawingApp
//
//  Created by YEONGJIN JANG on 2022/03/04.
//

import Foundation

struct RectangleView: CustomStringConvertible {
    enum Alpha: Int {
        case one = 1
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        
        static func random() -> Self  {
            let randomInt = Int.random(in: 1...10)
            var alpha: Alpha = .one
            switch randomInt{
            case 1:
                alpha = .one
            case 2:
                alpha = .two
            case 3:
                alpha = .three
            case 4:
                alpha = .four
            case 5:
                alpha = .five
            case 6:
                alpha = .six
            case 7:
                alpha = .seven
            case 8:
                alpha = .eight
            case 9:
                alpha = .nine
            default:
                alpha = .ten
            }
            return alpha
        }
    }
    
    struct BackgroundColor {
        let R: UInt8
        let G: UInt8
        let B: UInt8
    }
    struct Size {
        let width: Double = 150.0
        let height: Double = 120.0
    }
    struct Point {
        let x: Double
        let y: Double
    }

    var description: String {
        return "\(self.name) (\(self.id)), X:\(self.point.x), Y:\(self.point.y), W\(self.size.width), H\(self.size.height), R\(self.color.R), G\(self.color.G), B\(self.color.B), Alpha: \(self.alpha.rawValue)"
    }
    private let name: String
    private let id: String
    private let point: Point
    private let size : Size
    private var color: BackgroundColor
    private var alpha: Alpha
    
    
    init(name: String, id: String, point: Point, size: Size, color : BackgroundColor, alpha: Alpha) {
        self.name = name
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
}
