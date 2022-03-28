//
//  UIView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/28.
//

import Foundation
import UIKit

extension UIView {
    public static func addShadow(to view: UIView) {
        view.clipsToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .init(width: 2, height: 2)
        view.layer.shadowRadius = 2
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }
}

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
