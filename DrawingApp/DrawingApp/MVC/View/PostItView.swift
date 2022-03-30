//
//  PostItView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/28.
//

import Foundation
import UIKit

class PostItView: UITextView {
    
    let defaultInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: .init(size: frame.size))
        defaultSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        defaultSetup()
    }
    
    private func defaultSetup() {
        self.isEditable = false
        self.textContainerInset = defaultInset
        self.addShadow()
    }
    
}

extension PostItView {
    public override func copy(with zone: NSZone? = nil) -> Any {
        let copy = UITextView(frame: self.frame)
        
        copy.text = self.text
        copy.backgroundColor = self.backgroundColor
        
        UIView.applyCopyEffect(copy)
        
        return copy
    }
    
    private func addShadow() {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .init(width: 2, height: 2)
        self.layer.shadowRadius = 2
    }
}

extension PostItView: TextMutable {
    var getText: String {
        return self.text ?? ""
    }
    
    func set(to text: String) {
        self.text = text
    }
}
