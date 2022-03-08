//
//  Extensions.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/08.
//

import UIKit

extension UIColor {
    convenience init(color: Color) {
        self.init(red: CGFloat(color.red) / 255.0, green: CGFloat(color.green) / 255.0, blue: CGFloat(color.blue) / 255.0, alpha: 1.0)
    }
}
