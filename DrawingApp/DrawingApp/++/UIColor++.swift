//
//  UIColor++.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/05.
//

import UIKit

extension UIColor {
    
    convenience init(rgb:RGB,alpha:Alpha) {
        let red = rgb.red
        let green = rgb.green
        let blue = rgb.blue
        let alpha = alpha.value
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha))
    }
}
