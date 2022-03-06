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
    private var _r: Double
    var r: Double {
        get {
            _r
        }
        set {
            if 0...255 ~= newValue {
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
            if 0...255 ~= newValue {
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
            if 0...255 ~= newValue {
                _b = newValue
            }
        }
    }
    
    init?(r: Double, g: Double, b: Double) {
        if !(0...255 ~= r) || !(0...255 ~= g) || !(0...255 ~= b) {
            return nil
        }
        
        self._r = r
        self._g = g
        self._b = b
    }
}

// MARK: - CustomStringConvertible

extension RectRGBColor: CustomStringConvertible {
    var description: String {
        "R:\(r), G:\(g), B:\(b)"
    }
}
