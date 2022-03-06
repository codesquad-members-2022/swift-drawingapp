//
//  RandomPropertySubTypes.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/04.
//

import Foundation

// MARK: - Rect Size, Origin

struct Rect {
    struct Size {
        var width: Double
        var height: Double
    }

    struct Origin {
        var x: Double
        var y: Double
    }
}

typealias RectSize = Rect.Size
typealias RectOrigin = Rect.Origin

// MARK: - CustomStringConvertible

extension Rect.Size: CustomStringConvertible {
    var description: String {
        "W\(width), H\(height)"
    }
}

extension Rect.Origin: CustomStringConvertible {
    var description: String {
        "X:\(x),Y:\(y)"
    }
}

// MARK: - RectRGBColor

struct RectRGBColor {
    var r: Double
    var g: Double
    var b: Double
}

// MARK: - CustomStringConvertible

extension RectRGBColor: CustomStringConvertible {
    var description: String {
        "R:\(r), G:\(g), B:\(b)"
    }
}
