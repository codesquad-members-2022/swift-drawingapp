//
//  PhotoRectangle.swift
//  DrawingApp
//
//  Created by dale on 2022/03/14.
//

import Foundation

class PhotoRectangle: Rectangle {
    var backGroundImage : Data
    
    init(size: Size, position: Position, imageData: Data, alpha: Alpha) {
        self.backGroundImage = imageData
        super.init(size: size, position: position, color: nil, alpha: alpha)
    }
}
