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
        self.setDefaultConfiguration()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setDefaultConfiguration()
    }
    
    func setDefaultConfiguration() {
        let fontColor = UIColor(named: "Font")
        let borderColor = UIColor(named: "Border")
        let backgroundColor = UIColor(named: "Background")
        
        self.tintColor = fontColor
        self.backgroundColor = backgroundColor
        self.setTitle("Button", for: .normal)
        self.setBorder(width: 1, radius: 10, color: borderColor)
    }
    
    func setBorder(width: Int, radius: Int = 0, color: UIColor?) {
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color?.cgColor
    }
}
