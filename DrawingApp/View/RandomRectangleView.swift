//
//  RandomRectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import UIKit
import os

class RandomRectangleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func attribute(rectangle: Rectangle){
        self.backgroundColor = UIColor(red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
        self.restorationIdentifier = rectangle.id
    }
    
    private func layout(rectangle: Rectangle){
        self.frame = CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height)
    }
    
    func makeRectangleView(rectangle: Rectangle) -> UIView{
        layout(rectangle: rectangle)
        attribute(rectangle: rectangle)
        
        return self
    }
}
