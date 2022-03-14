//
//  RandomRectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import UIKit

final class RectangleView: UIView, ViewDragable{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func movingCenterPosition(x: Double, y: Double){
        self.center.x += x
        self.center.y += y
    }
    
    func changeCenterPositon(x: Double, y: Double){
        self.center.x = x
        self.center.y = y
    }
}
