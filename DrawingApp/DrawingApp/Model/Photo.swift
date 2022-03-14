//
//  Photo.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/14.
//

import Foundation

class Photo: Rectangle {
    private(set) var image: Data
    
    init(id: ID, size: Size, point: Point, image: Data, alpha: Alpha) {
        self.image = image
        super.init(id: id, size: size, point: point, backgroundColor: BackgroundColor.init(r: 0, g: 0, b: 0), alpha: alpha)
    }
}
