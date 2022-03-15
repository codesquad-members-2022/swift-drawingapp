//
//  UIView.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/14.
//

import Foundation
import UIKit
import os

extension UIView: ViewDragable{
    func copyCustomView() -> UIView{
        if let rectView = self as? RectangleView, let extraView = rectView.copy() as? UIView{
            return extraView
        } else if let imageView = self as? ImageView, let extraView = imageView.copy() as? UIView{
            return extraView
        } else{
            os_log("There is no match downcasting")
            return UIView()
        }
    }
    
}
