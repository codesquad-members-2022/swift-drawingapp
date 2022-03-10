//
//  CavasView.swift
//  DrawingApp
//
//  Created by dale on 2022/03/08.
//

import UIKit

class RectangleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(from rectangleFrame: CGRect, color: Color, alpha: Alpha) {
        self.init(frame: rectangleFrame)
        setBackgroundColor(color: color)
        setAlpha(alpha: alpha)
    }

    func setAlpha(alpha: Alpha) {
        self.alpha = alpha.transparency
    }
    
    func setBackgroundColor(color : Color) {
        self.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
    }
}
