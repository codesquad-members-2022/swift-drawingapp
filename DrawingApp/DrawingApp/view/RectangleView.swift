//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation
import UIKit

class RectangleView: UIView{
    init(size: ViewSize, point: ViewPoint){
        super.init(frame: CGRect(x: point.x, y: point.y, width: size.width, height: size.height))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setRGBColor(rgb: ColorRGB){
        backgroundColor = UIColor(cgColor: CGColor(red: CGFloat(rgb.r)/255, green: CGFloat(rgb.g)/255, blue: CGFloat(rgb.b)/255, alpha: 1))
    }
    
    func setAlpha(alpha: Double){
        self.alpha = alpha
    }
}

