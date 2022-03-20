//
//  UIColor+Extension.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/18.
//

import UIKit

extension UIColor {
    func hexCode() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format:"#%02X%02X%02X", Int(r*255.0) & 0xFF, Int(g*255.0) & 0xFF, Int(b*255.0) & 0xFF)
    }
}
