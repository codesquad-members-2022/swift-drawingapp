//
//  SquareView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class SquareView: UIView {
    func update(in model: Square) {
        backgroundColor = model.uiColor
        frame = model.rect
    }
    
    func selected(is select: Bool) {
        self.layer.borderWidth = select ? 3 : 0
        self.layer.borderColor = select ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
    }
}
