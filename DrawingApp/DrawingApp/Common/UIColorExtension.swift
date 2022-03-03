//
//  UIColorExtension.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/03.
//

import Foundation
import UIKit

extension UIColor {
    func toHex() -> String? {
        guard let components = cgColor.components, components.count >= 3 else { return nil }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
    
    var isDark: Bool {
        guard let components = cgColor.components, components.count >= 3 else { return false }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let darkBoundary = Float(1.5)
        
        return r+g+b >= darkBoundary
    }
}
