//
//  RectangleViewBoard.swift
//  DrawingApp
//
//  Created by dale on 2022/03/08.
//

import UIKit

protocol RectangleViewBoardDelegate {
    func didUpdatedColor()
}

class RectangleViewBoard: UIView {
    var selectedRectangleView : RectangleView?
    var delegate : RectangleViewBoardDelegate?
    
    func updateAlpha(alpha : Alpha) {
        self.selectedRectangleView?.setAlpha(alpha: alpha)
    }
    
    func updateColor(color : Color) {
        self.selectedRectangleView?.setBackgroundColor(color: color)
        delegate?.didUpdatedColor()
    }
}
