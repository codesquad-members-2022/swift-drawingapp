//
//  ImageRectangleProperty.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/16.
//

import Foundation

final class ImageRectangleProperty: RectangleProperty {
    private(set) var imageData: Data
    
    init(as name: String, using id: String, from screenRect: ScreenSceneRect, alpha: Double, backgroundImageData: Data) {
        self.imageData = backgroundImageData
        super.init(as: name, using: id, from: screenRect, alpha: alpha)
    }
}

extension ImageRectangleProperty: CustomStringConvertible {
    var description: String {
        "\(name) \(id), \(point), \(size), Alpha:\(alpha)"
    }
}
