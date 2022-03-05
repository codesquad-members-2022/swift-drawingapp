//
//  CGRect++.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/03.
//

import UIKit

//미리 만든 Rectangle등의 객체를 이용해 View를 init할 수 있도록 선언해보았습니다.
extension UIView {
    convenience init(rect:Rectangle, rgb:RGB, alpha:Alpha) {
        let id = rect.id.description
        
        let x = rect.origin.x
        let y = rect.origin.y
        
        let width = rect.size.width
        let height = rect.size.height
        
        let red = rgb.red
        let green = rgb.green
        let blue = rgb.blue

        let alpha = alpha.value
        
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.backgroundColor = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: CGFloat(alpha))
        self.accessibilityIdentifier = id
        
    }
}
