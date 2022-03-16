//
//  CavasView.swift
//  DrawingApp
//
//  Created by dale on 2022/03/08.
//

import UIKit

class RectangleView: UIView, ShapeViewAble{
    
    init(frame: CGRect, color: Color, alpha: Alpha) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.blue.cgColor
        setAlpha(alpha: alpha)
        setBackgroundColor(color: color)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func borderVisible(_ enable : Bool) {
        self.layer.borderWidth = enable ? 2 : 0
    }
    
    func setAlpha(alpha: Alpha) {
        self.alpha = alpha.transparency
    }
    
    func setBackgroundColor(color : Color) {
        self.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
    }
}
