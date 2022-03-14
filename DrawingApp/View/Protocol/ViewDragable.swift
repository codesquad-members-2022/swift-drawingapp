//
//  ViewDragable.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/14.
//

import Foundation
import UIKit

protocol ViewDragable{
    func movingExtraViewCenterPosition(view: UIView, x: Double, y: Double)
    func changeOriginalViewCenterPositon(view: UIView, x: Double, y: Double)
}

extension ViewDragable{
    func movingExtraViewCenterPosition(view: UIView, x: Double, y: Double){
        view.center.x += x
        view.center.y += y
    }
    
    func changeOriginalViewCenterPositon(view: UIView, x: Double, y: Double){
        view.center.x = x
        view.center.y = y
    }
}
