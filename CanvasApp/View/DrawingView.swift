//
//  DrawingView.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/19.
//

import UIKit

class DrawingView : UIView, ColorfulView {
    func makeLayer(color: CGColor, with points:[CGPoint]) {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 3
        layer.strokeColor = color
        let path = CGMutablePath()
        path.move(to: points.first!)
        for point in points {
            path.addLine(to: point)
        }
        layer.path = path
        self.layer.addSublayer(layer)
    }
    
    func changeColor(with color: CGColor) {
        guard let shapeLayer = self.layer.sublayers?.first as? CAShapeLayer else { return }
        shapeLayer.strokeColor = color
        self.layer.setNeedsDisplay()
    }
}
