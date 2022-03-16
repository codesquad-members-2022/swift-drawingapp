//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/16.
//
//

import UIKit

enum RectangleViewFactory {
    static func makeView(ofClass Class: RectangleShapable.Type, with data: Rectangle) -> RectangleShapable? {
        switch Class {
        case is RectangleView.Type:
            let rectangleView = RectangleView(frame: data.convert(using: CGRect.self))
            
            rectangleView.setBackgroundColor(color: data.backgroundColor, alpha: data.alpha)
            
            return rectangleView
        case is ImageRectangleView.Type:
            guard let data = data as? ImageRectangle else { return nil }
            guard let path = data.image?.path, let image = UIImage(contentsOfFile: path) else { return nil }
            
            let imageRectangleView = ImageRectangleView(frame: data.convert(using: CGRect.self))
            
            imageRectangleView.setImage(image)
            
            return imageRectangleView
        default:
            return nil
        }
    }
}
