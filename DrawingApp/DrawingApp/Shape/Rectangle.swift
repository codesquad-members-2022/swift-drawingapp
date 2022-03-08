//
//  Rectangle.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/02.
//

import Foundation


class Rectangle {
    let uniqueID: String
    var size: Size
    var color: Color
    var point: Point
    private(set) var alpha: Int = 1 {
        didSet {
            alpha = adjustRange(opacity: oldValue)
        }
    }
    
    init(uid: String, point: Point, size: Size, color: Color, alpha: Int) {
        self.uniqueID = uid
        self.point = point
        self.size = size
        self.color = color
        self.alpha = adjustRange(opacity: alpha)
    }
    
    convenience init(uid: String, point: Point = .zero, size: Size, colorType: Color.Standard = .white) {
        self.init(uid: uid, point: point, size: size, color: colorType.rgb, alpha: 1)
    }
    
    func contain(inside targetPoint: Point) -> Bool {
        if (targetPoint.x >= self.point.x && targetPoint.x <= self.point.x + self.size.width)
        && (targetPoint.y >= self.point.y && targetPoint.y <= self.point.y + self.size.height) {
            return true
        }
        return false
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
