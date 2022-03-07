//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation
import UIKit

/// 실제 MainScreenViewController.view에 생성될 뷰 클래스입니다.
final class Rectangle: UIView {
    
    private(set) var index: Int = 0
    
    var isSelected = false {
        didSet {
            borderWidth = isSelected ? 3:0
            borderColor = isSelected ? .tintColor : .clear
        }
    }
    
    /// 모델에 따라 뷰를 만듭니다.
    convenience init(model: RectangleProperty, index: Int) {
        let origin = CGPoint(x: model.point.x, y: model.point.y)
        let size = CGSize(width: model.size.width, height: model.size.height)
        self.init(frame: CGRect(origin: origin, size: size))
        self.index = index
        setBackgroundColor(using: model.rgbValue, alpha: model.alpha)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Methods Property Change
    func setValue(alpha: Float) {
        backgroundColor = backgroundColor?.withAlphaComponent((CGFloat(alpha / 10)))
    }
    
    func setBackgroundColor(using color: RectRGBColor, alpha: Double) {
        backgroundColor = UIColor(
            red: color.r/RectRGBColor.maxValue,
            green: color.g/RectRGBColor.maxValue,
            blue: color.b/RectRGBColor.maxValue,
            alpha: alpha/10
        )
    }
}
