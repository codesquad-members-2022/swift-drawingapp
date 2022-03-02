//
//  Rectangle.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/02.
//

import Foundation

class Rectangle {
    private let uniqueID: String
    private let size: Size
    private let color: Color
    private let point: Point
    private(set) var alpha: Int = 0 {
        didSet {
            alpha = adjustRange(opacity: oldValue)
        }
    }
    
    init(point: Point, size: Size, color: Color, alpha: Int) {
        self.uniqueID = "123-456-789"
        self.point = point
        self.size = size
        self.color = color
        self.alpha = adjustRange(opacity: alpha)
    }
}

extension Rectangle {
    struct Size {
        let width: Double
        let height: Double
    }

    struct Point {
        let x: Double
        let y: Double
    }
}

extension Rectangle {
    private func adjustRange(opacity: Int) -> Int {
        let min = 1
        let max = 10
        if opacity < min {
            return 0
        }
        if opacity > max {
            return 255
        }
        return opacity
    }
}

extension Rectangle: CustomStringConvertible {
    var description: String {
        "[\(self.uniqueID)]: (x:\(self.point.x), y:\(self.point.y)), (w:\(self.size.width),h:\(self.size.height)), (r:\(self.color.red),g:\(self.color.green),b:\(self.color.blue)), alpha:\(self.alpha)"
    }
}
