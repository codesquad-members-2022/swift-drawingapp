//
//  RectangleView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation
import UIKit

class RectangleView: DrawingView, Colorable {
    
    init(point: Point, size: Size, alpha: Alpha, color: Color) {
        super.init(frame: CGRect(x: point.x, y: point.y, width: size.width, height: size.height))
        self.update(alpha: alpha)
        self.update(color: color)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func update(color: Color) {
        canvasView.backgroundColor = UIColor(red: CGFloat(color.r) / 255, green: CGFloat(color.g) / 255, blue: CGFloat(color.b / 255), alpha: 1)
    }
}
