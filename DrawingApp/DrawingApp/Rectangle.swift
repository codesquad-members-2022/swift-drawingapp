//
//  Rectangle.swift
//  DrawingApp
//
//  Created by YEONGJIN JANG on 2022/03/04.
//

import Foundation

struct Rectangle: CustomStringConvertible {
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
        var R: UInt8 = 0
        var G: UInt8 = 0
        var B: UInt8 = 0
        
        mutating func random()  {
            let randomR: UInt8 = UInt8.random(in: 0...255)
            let randomG: UInt8 = UInt8.random(in: 0...255)
            let randomB: UInt8 = UInt8.random(in: 0...255)
            self.R = randomR
            self.G = randomG
            self.B = randomB
        }
        init() {
            random()
        }
    }
    struct Size {
        let width: Double = 150.0
        let height: Double = 120.0
    }
    struct Point {
        var x: Double = 0.0
        var y: Double = 0.0
        
        mutating func random() {
            let randomX: Double = Double.random(in: 20...1010)
            let randomY: Double = Double.random(in: 24...680)
            self.x = randomX
            self.y = randomY
        }
        
        init() {
            random()
        }
    }

    var description: String {
        return "(\(self.id)), X:\(self.point.x), Y:\(self.point.y), W\(self.size.width), H\(self.size.height), R\(self.color.R), G\(self.color.G), B\(self.color.B), Alpha: \(self.alpha.rawValue)"
    }
    
    private let id: String
    private let point: Point
    private let size : Size
    private var color: BackgroundColor
    private var alpha: Alpha
    
    
    init(id: String, point: Point, size: Size, color : BackgroundColor, alpha: Alpha) {
        self.id = id
        self.point = point
        self.size = size
        self.color = color
        self.alpha = alpha
    }
}
