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
        self.uniqueId = rectangle.uniqueId
        let point = rectangle.point
        let size = rectangle.size
        let rgb = rectangle.color
        let alpha = rectangle.alpha
        frame = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
        backgroundColor = UIColor(cgColor: CGColor(red: CGFloat(rgb.r)/255, green: CGFloat(rgb.g)/255, blue: CGFloat(rgb.b)/255, alpha: 1))
        self.alpha = CGFloat(alpha)
    }
    
}

