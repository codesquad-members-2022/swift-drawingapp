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
    
    func setCopiedView(rect: Rectangle) {
        copiedView = rect
    }
    
    func setAlpha(_ alpha: Double) {
        backgroundColor = backgroundColor?.withAlphaComponent(alpha)
    }
    
    @objc func drag(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(.zero, in: self)
        isSelected = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touches.count == 2 else { return }
        
        removeFromSuperview()
    }
    
    func coverOpaqueView() {
        let opaqueView = UIView(frame: self.bounds)
        addSubview(opaqueView)
        opaqueView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }
}
