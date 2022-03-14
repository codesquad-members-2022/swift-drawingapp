//
//  CustomViewFactory.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/14.
//

import Foundation
import UIKit

final class CustomViewFactory{
    func makeRectangleView(value: Rectangle) -> RectangleView{
        let rectangleView = RectangleView(frame: CGRect(x: value.point.x, y: value.point.y, width: value.size.width, height: value.size.height))
        rectangleView.backgroundColor = UIColor(red: value.color.redValue(), green: value.color.greenValue(), blue: value.color.blueValue(), alpha: value.alpha.showValue())
        rectangleView.restorationIdentifier = value.id
        
        return rectangleView
    }
    
    func makeBackgroundColor(){
        
    }
}
