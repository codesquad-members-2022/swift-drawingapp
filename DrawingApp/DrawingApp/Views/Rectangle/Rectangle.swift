//
//  Rectangle.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import UIKit

protocol IndexedRectangle {
    var index: Int { get set }
}

protocol EnableSetAlphaRectangle {
    func setValue(alpha: CGFloat)
}

/// MainScreen 등에서 사용되는 사각형들의 슈퍼 클래스입니다.
///
/// Inherited by ImageRectangle, ColoredRectangle classes
class Rectangle: UIView, IndexedRectangle {
    
    var index: Int = 0
    // copiedView 변수는 Rectangle이 바로 참조할 수 있도록 하기 위함입니다.
    private(set) var copiedView: Rectangle?
    
    var isSelected = false {
        didSet {
            borderWidth = isSelected ? 3:0
            borderColor = isSelected ? .tintColor : .clear
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setCopiedView(rect: Rectangle?) {
        copiedView = rect
    }
    
    func setAlpha(_ alpha: Double) {
        backgroundColor = backgroundColor?.withAlphaComponent(alpha)
    }
}
