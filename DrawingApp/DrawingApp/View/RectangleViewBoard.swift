//
//  RectangleViewBoard.swift
//  DrawingApp
//
//  Created by dale on 2022/03/08.
//

import UIKit

protocol RectangleViewBoardDelegate {
    func rectangleViewBoardDidUpdatedColor()
}

class RectangleViewBoard: UIView {
    var selectedRectangleView : RectangleView?
    var delegate : RectangleViewBoardDelegate?
    
    func updateAlpha(alpha : Alpha) {
        self.selectedRectangleView?.setAlpha(alpha: alpha)
    }
    
    func updateColor(color : Color) {
        self.selectedRectangleView?.setBackgroundColor(color: color)
        delegate?.rectangleViewBoardDidUpdatedColor()
    }
    
    func setSelectedRectangleView(rectangleView: RectangleView?) {
        if self.selectedRectangleView != nil {
            self.selectedRectangleView?.layer.borderWidth = 0
            self.selectedRectangleView = nil
        }
        self.selectedRectangleView = rectangleView
        self.selectedRectangleView?.layer.borderWidth = 2
        self.selectedRectangleView?.layer.borderColor = UIColor.blue.cgColor
    }
}
