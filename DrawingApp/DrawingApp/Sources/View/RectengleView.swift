//
//  RectengleView.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/15.
//

import UIKit

class RectengleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(frame: CGRect, color: Color, alpha: Alpha) {
        self.init(frame: frame)
        setColor(color: color, alpha: alpha)
    }
    
    func setColor(color: Color, alpha: Alpha) {
        self.backgroundColor = UIColor(red: color.r, green: color.g, blue: color.b, alpha: alpha.value)
    }
    
    func selectRectangle(isSelect: Bool) { // 선택된 사각형 테두리
        if isSelect == true {
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 5
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 0
        }
    }

}
