//
//  PlaneRectangleView.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/05.
//

import UIKit


final class PlaneRectangleView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupFrameWithPlaneRectangle(rect:Rectangle) {
        guard let planeRectangle = rect as? PlaneRectangle else { return }
        let x = planeRectangle.origin.x
        let y = planeRectangle.origin.y
        let width = planeRectangle.size.width
        let height = planeRectangle.size.height
        self.frame = CGRect(x: x, y: y, width: width, height: height)
    }

    func setupBackGroundColor(rgb:RGB, alpha:Alpha) {
        let red = rgb.red
        let green = rgb.green
        let blue = rgb.blue
        self.backgroundColor = UIColor(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha.value)
        )
    }

    
    
}
