//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation
import UIKit

protocol RectangleViewTapDelegate {
    func changeCurrentSelected(_ rectangle: Rectangle)
}

class Rectangle: UIView {
    
    var index: Int = 0
    
    var isSelected = false {
        didSet {
            borderWidth = isSelected ? 3:0
            borderColor = isSelected ? UIColor.tintColor : UIColor.clear
        }
    }
    
    var delegate: RectangleViewTapDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: RectangleProperty) {
        
        let origin = model.point
        let size = model.size
        
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height))
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
        
        setBackgroundColor(using: model)
    }
    
    func setModel(_ model: RectangleProperty) {
        let origin = model.point
        let size = model.size
        frame = CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
        setBackgroundColor(using: model)
    }
    
    func setValue(alpha: Float) {
        backgroundColor = backgroundColor?.withAlphaComponent((CGFloat(alpha / 10)))
    }
    
    func setBackgroundColor(using model: RectangleProperty) {
        
        let color = model.rgbValue
        
        backgroundColor = UIColor(
            red: color.r/255,
            green: color.g/255,
            blue: color.b/255,
            alpha: model.alpha/10
        )
    }
}

extension Rectangle: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        delegate?.changeCurrentSelected(self)
        return true
    }
}
