//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/09.
//

import UIKit

//TODO: 뷰팩토리로 변경
    //뷰팩토리 -> 다형성으로 알아서 처리 되도록 상위타입으로 넘겨줌
    //받을때는 자신이 조건식으로 업캐스팅해봐서 맞는 타입에 처리

class RectangleView: UIView {
    
    private var isHighlighted: Bool = false
    
    //MARK: Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    convenience init(frame: CGRect, backgroundColor: UIColor, alpha: CGFloat) {
        self.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.alpha = alpha
    }
    
    
    //MARK: Functions
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func highlightCorner() {
        layer.borderColor = UIColor.systemCyan.cgColor
        layer.borderWidth = 5
        isHighlighted = true
    }
    
    func clearCorner() {
        layer.borderWidth = 0
        layer.borderColor = .none
        isHighlighted = false
    }
    
    func toggleCorner() {
        isHighlighted ? clearCorner() : highlightCorner()
    }
    
    func changeAlpha(to alphaLevel: CGFloat) {
        alpha = alphaLevel
    }
    
    func changeBackgroundColor(by color: UIColor) {
        backgroundColor = color
    }
}
