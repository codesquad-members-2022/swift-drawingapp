//
//  ViewFactory.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/17.
//

import UIKit

enum ViewFactory {
    static func makeRect(with rect: BaseRect & RectColorful) -> RectView {
        let newView = RectView(frame: CGRect(origin: rect.origin,
                                        size: rect.size))
        newView.backgroundColor = UIColor.init(cgColor: rect.color)
        return newView
    }

    static func makePicture(with rect: BaseRect & PictureAccessable) -> PictureView {
        let newView = PictureView(frame: CGRect(origin: rect.origin,
                                        size: rect.size))
        newView.image = UIImage.init(contentsOfFile: rect.media.path)
        return newView
    }
    
    static func makeDrawing(with rect: BaseRect & RectColorful & PointAccessable) -> DrawingView {
        let newView = DrawingView(frame: CGRect(origin: rect.origin,
                                        size: rect.size))
        newView.makeLayer(color: rect.color, with: rect.points)
        return newView
    }
}
