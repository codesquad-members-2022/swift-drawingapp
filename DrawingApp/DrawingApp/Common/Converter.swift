//
//  Converter.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/03.
//

import Foundation
import UIKit

extension CGFloat {
    init(with alpha: Alpha) {
        self.init(alpha.value)
    }
}

extension CGPoint {
    init(with point: Point) {
        self.init(x: point.x, y: point.y)
    }
}

extension CGSize {
    init(with size: Size) {
        self.init(width: size.width, height: size.height)
    }
}

extension CGRect {
    init(origin: Point, size: Size) {
        self.init(origin: CGPoint(with: origin), size: CGSize(with: size))
    }
}

extension UIColor {
    convenience init(with color: Color) {
        self.init(red: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: CGFloat(color.alpha))
    }
}
