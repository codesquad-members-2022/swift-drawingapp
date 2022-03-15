//
//  CustomViewFactory.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/14.
//

import Foundation
import UIKit

final class CustomViewFactory{
    static func makeViewFrame(value: Rectangle) -> RectangleView{
        let rectangleView = RectangleView(frame: CGRect(x: value.point.x, y: value.point.y, width: value.size.width, height: value.size.height))
        
        return rectangleView
    }
    
    static func makeViewFrame(value: Image) -> ImageView{
        let imageView = ImageView(frame: CGRect(x: value.point.x, y: value.point.y, width: value.size.width, height: value.size.height))
        
        return imageView
    }
    
    static func setRectangleViewBackgroundColor(value: Rectangle) -> UIColor{
        return UIColor(red: value.color.redValue(), green: value.color.greenValue(), blue: value.color.blueValue(), alpha: value.alpha.showValue())
    }
    
    static func setImageViewInnerImage(value: Image) -> UIImage {
        return value.showMyImage().showUIImage()
    }
    
    static func setImageViewAlpha(value: Image) -> Double{
        return value.alpha.showValue()
    }
    
    static func setViewID(value: RectValue) -> String{
        return value.showValueId()
    }
}
