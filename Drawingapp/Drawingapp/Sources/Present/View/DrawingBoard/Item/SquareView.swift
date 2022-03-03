//
//  SquareView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class SquareView {
    let view = UIView()
    
    func update(in model: Square) {
        let color = model.color
        view.backgroundColor = UIColor(red: CGFloat(color.r) / 255, green: CGFloat(color.g) / 255, blue: CGFloat(color.b / 255), alpha: 1)
        
        let point = model.point
        let size = model.size
        view.frame = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
    }
    
    func selected(is select: Bool) {
        self.view.layer.borderWidth = select ? 3 : 0
        self.view.layer.borderColor = select ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
    }
}
