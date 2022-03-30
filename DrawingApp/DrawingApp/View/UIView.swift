//
//  UIView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/28.
//

import Foundation
import UIKit

// UIView represents Rectangle Class

extension UIView: NSCopying {
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = UIView(frame: self.frame)
        
        if let backgroundColor = self.backgroundColor {
            copy.backgroundColor = backgroundColor
        }
        
        UIView.applyCopyEffect(copy)
        
        return copy
    }
    
    static func applyCopyEffect(_ copy: UIView) {
        copy.alpha *= 0.5
        copy.layer.shadowColor = UIColor.black.cgColor
        copy.layer.shadowOpacity = 1
        copy.layer.shadowOffset = .zero
        copy.layer.shouldRasterize = true
    }
}
