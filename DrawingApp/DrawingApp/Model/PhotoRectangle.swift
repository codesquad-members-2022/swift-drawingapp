//
//  PhotoRectangle.swift
//  DrawingApp
//
//  Created by dale on 2022/03/16.
//

import Foundation

class PhotoRectangle: Shape{
    var backgroundImage: Data
    
    init(size: Size, position: Position, imageData: Data, alpha: Alpha) {
        self.backgroundImage = imageData
        super.init(size: size, position: position, alpha: alpha)
    }
}

extension PhotoRectangle : CustomStringConvertible{
    var description: String {
        return "(\(self.id)), \(position), \(self.size), \(self.backgroundImage) , \(self.alpha)"
    }
}
