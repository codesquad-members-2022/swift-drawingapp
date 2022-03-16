//
//  CustomViewFactory.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/16.
//

import Foundation

class CustomViewFactory{
    private func makeCustomRectangleView(size: ViewSize, point: ViewPoint) -> RectangleViewSetable{
        return RectangleView(size: size, point: point)
    }
    
    private func makeCustomPhotoView(size: ViewSize, point: ViewPoint) -> PhotoViewSetable{
        return PhotoView(size: size, point: point)
    }
}
extension CustomViewFactory: CustomViewMakeable{
    func makeRectangleView(size: ViewSize, point: ViewPoint) -> RectangleViewSetable {
        return makeCustomRectangleView(size: size, point: point)
    }
    
    func makePhotoView(size: ViewSize, point: ViewPoint) -> PhotoViewSetable {
        return makeCustomPhotoView(size: size, point: point)
    }
}
protocol CustomViewMakeable{
    func makeRectangleView(size: ViewSize, point: ViewPoint) -> RectangleViewSetable
    func makePhotoView(size: ViewSize, point: ViewPoint) -> PhotoViewSetable
}
