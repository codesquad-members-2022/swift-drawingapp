//
//  RectanlgeViewFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/15.
//

final class RectanlgeViewFactory:RectangleViewCreator {
    static func makeRectangleView(sourceRectangle: Rectangleable) -> RectangleViewable {
        switch type(of: sourceRectangle) {
        case is ImageRectangle:
            let rectangle = ImageRectanlgeView(frame:.zero)
            rectangle.setupFrameWithRectangle(rect: sourceRectangle)
            return rectangle
        default:
            let source = sourceRectangle as! PlaneRectangle
            let rectangle = PlaneRectangleView()
            rectangle.setupFrameWithRectangle(rect: sourceRectangle)
            rectangle.setupBackGroundColor(rgb: source.rgb ?? RGB(red: 0, green: 0, blue: 0), alpha: source.alpha ?? Alpha(1.0))
            return rectangle
        }
        
    }
}
