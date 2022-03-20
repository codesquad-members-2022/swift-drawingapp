//
//  FigureFactory.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/18.
//

import Foundation
import CoreGraphics

enum FigureFactory {
    static var rectSequence = 0
    static func makeRect(origin: CGPoint, size: CGSize, color: CGColor) -> Rectangle {
        rectSequence += 1
        return Rectangle.init(origin: origin, size: size, color: color, sequence: rectSequence)
    }

    static var pictureSequence = 0
    static func makePicture(origin: CGPoint, size: CGSize, media: URL) -> Picture {
        pictureSequence += 1
        return Picture.init(origin: origin, size: size, media: media, sequence: pictureSequence)
    }

    static var drawingSequence = 0
    static func makeDrawing(origin: CGPoint, size: CGSize, with points: [CGPoint], color: CGColor) -> Drawing {
        drawingSequence += 1
        return Drawing.init(origin: origin, size: size, points: points, color: color, sequence: drawingSequence)
    }
}

