//
//  RoundedButton.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/07.
//

import UIKit

class RoundedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setDefaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setDefaultConfiguration()
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.setDefaultConfiguration()
        self.setTitle(title, for: .normal)
    }
    
    func setDefaultConfiguration() {
        let fontColor = UIColor(named: "Font")
        let borderColor = UIColor(named: "Border")
        let backgroundColor = UIColor(named: "Background")

        self.configuration = UIButton.Configuration.plain()
        self.frame.size = CGSize(width: 120, height: 80)
        self.tintColor = fontColor
        self.backgroundColor = backgroundColor
        self.setTitle("Button", for: .normal)
        self.setBorder(width: 1, radius: 10, color: borderColor)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
    }
    
    func setBorder(width: Int, radius: Int = 0, color: UIColor?) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color?.cgColor
    }
    
    func setCorners(_ corners: UIRectCorner, radius: Int) {
        var cornerMask = CACornerMask()
        
        if corners.contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        
        if corners.contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        
        if corners.contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        
        if corners.contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        
        if corners.contains(.allCorners) {
            cornerMask = [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
        }
        
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.maskedCorners = cornerMask
    }
    
    func setImage(_ image: UIImage?, for state: UIControl.State, on placement: NSDirectionalRectEdge, with padding: Int) {
        self.setImage(image, for: state)
        self.configuration?.imagePlacement = placement
        self.configuration?.imagePadding = CGFloat(padding)
    }
}
