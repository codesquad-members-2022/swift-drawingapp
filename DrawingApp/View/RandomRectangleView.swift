//
//  RandomRectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import UIKit
import os

class RandomRectangleView: UIView {
    init(id: String, point: MyPoint, size: MySize, color: RGBColor, alpha: Alpha){
        let frame = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
        super.init(frame: frame)
        
        self.frame = frame
        self.backgroundColor = UIColor(red: color.redValue(), green: color.greenValue(), blue: color.blueValue(), alpha: alpha.showValue())
        self.restorationIdentifier = id
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
