//
//  CustomViewFactory.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/14.
//

import Foundation
import UIKit

final class CustomViewFactory{
    func makeViewFrame(value: Rectangle) -> RectangleView{
        let rectangleView = RectangleView(frame: CGRect(x: value.point.x, y: value.point.y, width: value.size.width, height: value.size.height))
        
        return rectangleView
    }
    
    func makeViewFrame(value: Image) -> ImageView{
        let imageView = ImageView(frame: CGRect(x: value.point.x, y: value.point.y, width: value.size.width, height: value.size.height))
        
        return imageView
    }
    
    func setRectangleViewBackgroundColor(value: Rectangle) -> UIColor{
        return UIColor(red: value.color.redValue(), green: value.color.greenValue(), blue: value.color.blueValue(), alpha: value.alpha.showValue())
    }
    
    func setImageViewInnerImage(value: Image) -> UIImage {
        return value.image.image
    }
    
    func setImageViewAlpha(value: Image) -> Double{
        return value.alpha.showValue()
    }
    
    func setViewID(value: RectValue) -> String{
        return value.id
    }
}
