//
//  CopyExtension.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/14.
//

import Foundation
import UIKit

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

extension UIImageView {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = UIImageView(frame: self.frame)
        
        if let image = self.image { copy.image = image }
        
        UIView.applyCopyEffect(copy)
        
        return copy
    }
}


extension UILabel {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = UILabel(frame: self.frame)
        
        copy.text = self.text
        copy.font = UIFont.systemFont(ofSize: self.font.pointSize)
        copy.textColor = self.textColor
        
        UIView.applyCopyEffect(copy)
        
        return copy
    }
}
