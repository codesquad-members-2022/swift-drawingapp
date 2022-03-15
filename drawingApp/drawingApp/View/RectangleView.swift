//
//  RectangleView.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/03.
//

import UIKit

class RectangleView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func updateColor(with model: Model) {
        self.backgroundColor = UIColor(red: model.color.red.scaleRGB, green: model.color.green.scaleRGB, blue: model.color.blue.scaleRGB, alpha: model.alpha.scaledValue)
    }
    
    func updateAlpha(newAlpha : Double) {
        self.alpha = newAlpha
    }
    
    
    func configure(isSelected : Bool){
        if isSelected {
            self.layer.borderWidth = 4
            self.layer.borderColor = UIColor.blue.cgColor
        }else{
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    
}
