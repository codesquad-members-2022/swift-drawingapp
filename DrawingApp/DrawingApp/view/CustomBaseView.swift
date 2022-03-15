//
//  CustomBaseView.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/15.
//

import Foundation
import UIKit

class CustomBaseView: UIView{
    init(size: ViewSize, point: ViewPoint){
        super.init(frame: CGRect(x: point.x, y: point.y, width: size.width, height: size.height))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setAlpha(alpha: Double){
        self.alpha = alpha
    }
}
