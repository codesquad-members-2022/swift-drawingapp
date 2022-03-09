//
//  RandomPropertySubTypes.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/04.
//

import Foundation
import UIKit

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
    
    @ColorValue var r: Double
    @ColorValue var g: Double
    @ColorValue var b: Double
    
    /// If you indicate RectRGBColor values bigger than maxValue(255), it will be definitely 0.
    init?(r: Double, g: Double, b: Double) {
        self.r = r
        self.g = g
        self.b = b
    }
}

@propertyWrapper
struct ColorValue {
    private var _value: Double = 0
    
    var wrappedValue: Double {
        get {
            self._value
        }
        set {
            if newValue >= 0 {
                self._value = min(RectRGBColor.maxValue, newValue)
            }
        }
    }
}

extension RectRGBColor {
    /// Convert RectRGBColor to UIColor
    ///
    /// r,g,b,alpha all property divided by their own maxValue
    func getColor(alpha: Double) -> UIColor {
        UIColor(
            red: r/RectRGBColor.maxValue,
            green: g/RectRGBColor.maxValue,
            blue: b/RectRGBColor.maxValue,
            alpha: alpha/RectRGBColor.maxAlpha
        )
    }
}

// MARK: - CustomStringConvertible for RectRGBColor
extension RectRGBColor: CustomStringConvertible {
    var description: String {
        "R:\(r), G:\(g), B:\(b)"
    }
}
