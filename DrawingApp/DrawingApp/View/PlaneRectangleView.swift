//
//  PlaneRectangleView.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/05.
//

import UIKit

final class PlaneRectangleView:UIView {
    
    convenience init(rect: PlaneRectangle, rgb:RGB, alpha:Alpha) {
        let x = rect.origin.x
        let y = rect.origin.y
        
        let width = rect.size.width
        let height = rect.size.height
        
        let red = rgb.red
        let green = rgb.green
        let blue = rgb.blue
        
        let alpha = alpha.value
        
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.backgroundColor = UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha))
    }
}
