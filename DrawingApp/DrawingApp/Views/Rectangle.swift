//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation
import UIKit

class Rectangle: UIView {
    
    private var model: ViewRandomProperty
    
    var isSelected = false {
        didSet {
            borderWidth = isSelected ? 3:0
            borderColor = isSelected ? UIColor.tintColor : UIColor.clear
        }
    }
    
    var delegate: RectangleViewTapDelegate?
    
    init(randomProperty: ViewRandomProperty) {
        self.model = randomProperty
        
        super.init(frame: CGRect(
            x: model.point.x,
            y: model.point.y,
            width: model.size.width,
            height: model.size.height
        ))
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
        
        let rgbValue = model.rgbValue
        
        self.backgroundColor = UIColor(
            red: rgbValue.r/255,
            green: rgbValue.g/255,
            blue: rgbValue.b/255,
            alpha: CGFloat(randomProperty.alpha / 10)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAlpha(_ alpha: Double) {
        self.alpha = alpha
    }
    
    func setRandomColor() {
        let color = model.generateRandomRGBColor(maxR: 255, maxG: 255, maxB: 255)
        
        self.backgroundColor = UIColor(
            red: color.r,
            green: color.g,
            blue: color.b,
            alpha: CGFloat(model.alpha / 10)
        )
    }
    
    func getCGRect(from properties: ViewRandomProperty) -> CGRect {
        return CGRect(
            x: model.point.x,
            y: model.point.y,
            width: model.size.width,
            height: model.size.height
        )
    }
}

extension Rectangle: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        
        delegate?.setSelected(self)
        return true
    }
}
