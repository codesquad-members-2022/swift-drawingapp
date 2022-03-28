//
//  UITextView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/28.
//

import Foundation
import UIKit

extension UITextView {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = UITextView(frame: self.frame)
        
        copy.text = self.text
        copy.backgroundColor = self.backgroundColor
        
        UIView.applyCopyEffect(copy)
        
        return copy
    }
}

extension UITextView: TextMutable {
    var getText: String {
        return self.text ?? ""
    }
    
    func set(to text: String) {
        self.text = text
    }
}
