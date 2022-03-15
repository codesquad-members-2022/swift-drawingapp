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
    convenience init(model: RectangleProperty, index: Int, backgroundImage: UIImage? = nil) {
        let origin = CGPoint(x: model.point.x, y: model.point.y)
        let size = CGSize(width: model.size.width, height: model.size.height)
        self.init(frame: CGRect(origin: origin, size: size))
        self.index = index
        
        if model.hasViewProperty {
            addBackgroundImage(using: backgroundImage, alpha: model.alpha)
        } else {
            setBackgroundColor(using: model.rgbValue, alpha: model.alpha)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Methods Property Change
    func setValue(alpha: CGFloat) {
        if let imageView = subviews.first(where: {type(of: $0) == UIImageView.self}) as? UIImageView {
            imageView.alpha = alpha/10
        } else {
            backgroundColor = backgroundColor?.withAlphaComponent(alpha/10)
        }
    }
    
    func setBackgroundColor(using color: RectRGBColor, alpha: Double) {
        backgroundColor = color.getColor(alpha: alpha)
    }
    
    func addBackgroundImage(using image: UIImage?, alpha: Double) {
        let imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleToFill
        imageView.image = image
        imageView.alpha = alpha/10
        self.addSubview(imageView)
    }
}
