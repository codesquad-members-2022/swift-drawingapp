//
//  PhotoRectangle.swift
//  DrawingApp
//
//  Created by dale on 2022/03/14.
//

import Foundation
import UIKit

class PhotoRectangle: Rectangle {
    var backGroundImage : UIImage
    
    init(size: Size, position: Position, image: UIImage, alpha: Alpha) {
        self.backGroundImage = image
        super.init(size: size, position: position, color: nil, alpha: alpha)
    }
}
