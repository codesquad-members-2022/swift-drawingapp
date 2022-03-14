//
//  ImageRectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/14.
//

import Foundation

class ImageRectangle: Rectangle {
    private var image: Data
    
    // MARK: - Initializers
    init(id: String, origin: Point, size: Size, image: Data) {
        self.image = image
        super.init(id: id, origin: origin, size: size)
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, image: Data) {
        self.image = image
        super.init(id: id, x: x, y: y, width: width, height: height)
    }
}
