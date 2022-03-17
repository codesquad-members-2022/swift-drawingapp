//
//  RectanlgeViewFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/15.
//

final class RectanlgeViewFactory {
    
    static func makePlaneRectangleView(sourceRectangle: Rectangleable) -> PlaneRectangleView {
            let source = sourceRectangle as! PlaneRectangle
        let rectangle = PlaneRectangleView(frame: .zero)
            rectangle.setupFrameWithRectangle(rect: sourceRectangle)
            rectangle.setupBackGroundColor(rgb: source.rgb ?? RGB(red: 0, green: 0, blue: 0), alpha: source.alpha ?? Alpha(1.0))
            return rectangle
        
    }
    
    static func makeImageRectangleView(sourceRectangle: Rectangleable) -> ImageRectanlgeView {
            let source = sourceRectangle as! ImageRectangle
            let rectangle = ImageRectanlgeView(frame: .zero)
            rectangle.setupFrameWithRectangle(rect: sourceRectangle)
            rectangle.setupImage(imageData: source.imageData)
            return rectangle
    }
}
