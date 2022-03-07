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
        
        let fontColor = UIColor(named: "Font")
        let borderColor = UIColor(named: "Border")
        self.tintColor = fontColor
        self.setBorder(width: 1, radius: 10, color: borderColor)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let fontColor = UIColor(named: "Font")
        let borderColor = UIColor(named: "Border")
        self.tintColor = fontColor
        self.setBorder(width: 1, radius: 10, color: borderColor)
    }
    
    func setBorder(width: Int, radius: Int = 0, color: UIColor?) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color?.cgColor
    }
}
