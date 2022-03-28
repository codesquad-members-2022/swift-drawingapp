//
//  UILabel.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/28.
//

import Foundation
import UIKit

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

extension UILabel: TextMutable {
    var getText: String {
        return self.text ?? ""
    }
    
    func set(to text: String) {
        self.text = text
    }
}
