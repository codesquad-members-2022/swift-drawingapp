//
//  RectangleViewFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/18.
//

import UIKit

enum RectangleViewFactory: ShapeViewBuildable {
    static func makeView(ofClass type: ShapeViewable.Type, with data: Shapable) -> ShapeViewable? {
        switch type {
        case is ColoredRectangleView.Type:
            guard let data = data as? ColoredRectangle else { return nil }
            return self.makeColoredRectangleView(with: data)
        case is ImageRectangleView.Type:
            guard let data = data as? ImageRectangle else { return nil }
            return self.makeImageRectangleView(with: data)
        default:
            return nil
        }
    }
    
    static func makeColoredRectangleView(with data: ColoredRectangle) -> ColoredRectangleView {
        let rectangleView = ColoredRectangleView(frame: data.convert(using: CGRect.self))
        
        rectangleView.setBackgroundColor(color: data.backgroundColor, alpha: data.alpha)
        
        return rectangleView
    }
    
    static func makeImageRectangleView(with data: ImageRectangle) -> ImageRectangleView {
        if let path = data.imagePath, let image = UIImage(contentsOfFile: path) {
            
            let view = ImageRectangleView(frame: data.convert(using: CGRect.self))
            
            view.setImage(image)
            
            return view
        }
        
        return ImageRectangleView(frame: CGRect(with: data))
    }
}
