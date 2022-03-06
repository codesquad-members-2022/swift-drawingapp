//
//  UIView+Extensions.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation
import UIKit

// 특정 클래스에서만 작동하도록 할까도 고민하였지만, 유용하다는 생각이 들어서 모든 클래스에 적용되도록 하였습니다.
// [수정] 작동이 보장되지 않는 방법이므로, Rectangle에서 사용 가능한지 검토해보고 남겨둘지 결정합니다.
@IBDesignable
extension Rectangle {
    
    @IBInspectable var borderColor: UIColor {
        get {
            let color = layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
