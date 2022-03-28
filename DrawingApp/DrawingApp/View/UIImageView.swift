//
//  UIImageView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/28.
//

import Foundation
import UIKit

extension UIImageView {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = UIImageView(frame: self.frame)
        
        if let image = self.image { copy.image = image }
        
        UIView.applyCopyEffect(copy)
        
        return copy
    }
}
