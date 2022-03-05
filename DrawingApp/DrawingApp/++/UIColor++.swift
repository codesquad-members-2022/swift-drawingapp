//
//  UIColor++.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/05.
//

import UIKit

//rgb값을 UIColor로 init시키기 위해 만들었습니다.
extension UIColor {
    convenience init(rgb:RGB,alpha:Alpha) {
        let red = rgb.red
        let green = rgb.green
        let blue = rgb.blue
        let alpha = alpha.value
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha))
    }
}
