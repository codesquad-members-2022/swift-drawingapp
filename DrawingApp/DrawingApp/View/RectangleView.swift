//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/04.
//

import UIKit

class RectangleView: UIView {
    let id: ID
    override var description: String {
        return "ID = \(id); Frame = \(frame); alpha = \(alpha); backgroundColor = \(backgroundColor ?? .white)"
    }
    
    required override init(frame: CGRect) {
        self.id = ID.init()
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        self.id = ID.init()
        super.init(coder: coder)
    }
    
    init(id: ID, frame: CGRect, backgroundColor: UIColor, alpha: CGFloat) {
        self.id = id
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
}
