//
//  RectangleViewBoard.swift
//  DrawingApp
//
//  Created by dale on 2022/03/08.
//

import UIKit

protocol ShapeViewBoardDelegate {
    func shapeViewBoard(didUpdated color: Color)
}

class ShapeViewBoard: UIView {
    private var selectedView : ShapeViewAble?
    var delegate : ShapeViewBoardDelegate?
    
    func updateAlpha(alpha : Alpha) {
        self.selectedView?.setAlpha(alpha: alpha)
    }
    
    func updateColor(color : Color) {
        if let rectangleView = self.selectedView as? RectangleView{
            rectangleView.setBackgroundColor(color: color)
            delegate?.shapeViewBoard(didUpdated: color)
        }
    }
    
    func setSelectedView(of shapeView: ShapeViewAble?) {
        if self.selectedView != nil {
            self.selectedView?.borderVisible(false)
            self.selectedView = nil
        }
        self.selectedView = shapeView
        self.selectedView?.borderVisible(true)

    }
}
