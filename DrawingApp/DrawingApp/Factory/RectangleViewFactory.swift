//
//  RectanlgeViewFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/15.
//

import UIKit

final class RectangleViewFactory {
    
    //planeRectangleView
    static func makePlaneRectangleView(sourceRectangle: Rectangleable) -> UIView {
        let source = sourceRectangle as! PlaneRectangle
        let rectangleView = UIView(frame: .zero)
        rectangleView.frame = setUpFrameWithRectangle(source)
        rectangleView.backgroundColor = setupBackgroundColor(rgb: source.rgb, alpha: source.alpha)
        return rectangleView
    }
    
    //IamgeView
    static func makeImageRectangleView(sourceRectangle: Rectangleable) -> UIImageView {
        let source = sourceRectangle as! ImageRectangle
        let rectangleView = UIImageView(frame: .zero)
        rectangleView.frame = setUpFrameWithRectangle(source)
        rectangleView.image = setupImage(imageData: source.imageData)
        return rectangleView
    }
    
    
    //Setup private Static functions, Pure Func?
    private static func setUpFrameWithRectangle(_ source:Rectangleable) -> CGRect {
        let x = source.origin.x
        let y = source.origin.y
        let width = source.size.width
        let height = source.size.height
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private static func setupBackgroundColor(rgb:RGB, alpha:Alpha) -> UIColor {
            let red = rgb.red
            let green = rgb.green
            let blue = rgb.blue
            return UIColor(
                red: CGFloat(red) / 255,
                green: CGFloat(green) / 255,
                blue: CGFloat(blue) / 255,
                alpha: CGFloat(alpha.value)
            )
        }
    
    private static func setupImage(imageData:Data)  -> UIImage{
        return UIImage(data: imageData) ?? UIImage()
    }
    
}
