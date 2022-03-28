//
//  Photo.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/14.
//

import Foundation

protocol ImageDataHavable {
    var image: Data {get}
}

class Photo: BasicShape, ImageDataHavable {
    private(set) var image: Data
    
    init(size: Size, point: Point, image: Data, alpha: Alpha) {
        self.image = image
        super.init(size: size, point: point, alpha: alpha)
    }
}
