//
//  RectangleView.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/03.
//

import UIKit
protocol RectangleViewDelegate{
    func didTouchRectView(rectView: RectangleView)
}
class RectangleView: UIView {
    
    var selected = false {
        didSet{
//            print("사각형 뷰 선택됨 :: \(selected) with \(self.alpha)")
            if selected == true {
                delegate?.didTouchRectView(rectView: self)
            }
        }
    }
    var delegate : RectangleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func updateColor(with model: Rectangle) {
        self.backgroundColor = UIColor(red: model.color.red.scaleRGB, green: model.color.green.scaleRGB, blue: model.color.blue.scaleRGB, alpha: model.alpha.value)
    }
    
    func updateAlpha(newAlpha : Double) {
        self.alpha = newAlpha
    }
    
    
    func configure(didSelect : Bool){
        if didSelect {
            self.layer.borderWidth = 4
            self.layer.borderColor = UIColor.blue.cgColor
        }else{
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    
}
