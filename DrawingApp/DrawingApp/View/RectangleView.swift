//
//  CavasView.swift
//  DrawingApp
//
//  Created by dale on 2022/03/08.
//

import UIKit

class RectangleView: UIView {

    init(frame: CGRect, color: Color?, alpha: Alpha) {
        super.init(frame: frame)
        setAlpha(alpha: alpha)
        if let color = color {
            setBackgroundColor(color: color)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setAlpha(alpha: Alpha) {
        self.alpha = alpha.transparency
    }
    
    func setBackgroundColor(color : Color) {
        self.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
    }
}
