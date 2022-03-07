//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation
import UIKit

class Rectangle: UIView {
    
    private(set) var index: Int = 0
    
    var isSelected = false {
        didSet {
            borderWidth = isSelected ? 3:0
            borderColor = isSelected ? .tintColor : .clear
        }
    }
    
    var model: RectangleProperty?
    
    /// 모델에 따라 뷰를 만들고, 탭 제스쳐를 적용합니다.
    convenience init(model: RectangleProperty, index: Int) {
        let origin = model.point
        let size = model.size
        self.init(frame: CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height))
        self.index = index
        self.model = model
        setBackgroundColor(using: model.rgbValue, alpha: model.alpha)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setValue(alpha: Float) {
        backgroundColor = backgroundColor?.withAlphaComponent((CGFloat(alpha / 10)))
    }
    
    func setBackgroundColor(using color: RectRGBColor, alpha: Double) {
        backgroundColor = UIColor(red: color.r/255, green: color.g/255, blue: color.b/255, alpha: alpha/10)
    }
    
    @objc func rectTapHandler(_ recognizer: UITapGestureRecognizer) { }
}
