//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation
import UIKit

class RectangleView: UIView{
    private var uniqueId: String?
    
    init(){
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUniqueId(id: String){
        self.uniqueId = id
    }
    
    func idValue() -> String{
        return self.uniqueId ?? ""
    }
    
    func matchProperty(rectangle: Rectangle){
        self.uniqueId = rectangle.idValue()
        let point = rectangle.pointValue()
        let size = rectangle.sizeValue()
        let rgb = rectangle.colorValue()
        let alpha = rectangle.alphaValue()
        frame = CGRect(x: point.xValue(), y: point.yValue(), width: size.widthValue(), height: size.heightValue())
        backgroundColor = UIColor(cgColor: CGColor(red: rgb.rValue()/255, green: rgb.gValue()/255, blue: rgb.bValue()/255, alpha: 1))
        self.alpha = CGFloat(alpha)
    }
    
}

