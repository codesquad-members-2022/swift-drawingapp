//
//  RandomPropertySubTypes.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/04.
//

import Foundation

// MARK: - Rect Size, Origin
/// Rectangle 객체의 위치, 크기를 프로퍼티를 표현하는 타입입니다.
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

// MARK: - CustomStringConvertible for Rect
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
/// Rectangle 객체의 색상을 표현하는 타입입니다.
struct RectRGBColor {
    var allValues: [Double] { [r, g, b] }
    static var maxValue: Double = 255
    static var maxAlpha: Double = 10
    private var _r: Double
    var r: Double {
        get {
            _r
        }
        set {
            if 0...RectRGBColor.maxValue ~= newValue {
                _r = newValue
            }
        }
    }
    
    private var _g: Double
    var g: Double {
        get {
            _g
        }
        set {
            if 0...RectRGBColor.maxValue ~= newValue {
                _g = newValue
            }
        }
    }
    
    private var _b: Double
    var b: Double {
        get {
            _b
        }
        set {
            if 0...RectRGBColor.maxValue ~= newValue {
                _b = newValue
            }
        }
    }
    
    init?(r: Double, g: Double, b: Double) {
        if !(0...RectRGBColor.maxValue ~= r) || !(0...RectRGBColor.maxValue ~= g) || !(0...RectRGBColor.maxValue ~= b) {
            return nil
        }
        
        self._r = r
        self._g = g
        self._b = b
    }
}

// MARK: - CustomStringConvertible for RectRGBColor
extension RectRGBColor: CustomStringConvertible {
    var description: String {
        "R:\(r), G:\(g), B:\(b)"
    }
}
