//
//  ImageRectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/15.
//

import Foundation

protocol ImagePossessable {
    func setImage(with url: URL)
}

class ImageRectangle: Rectangle, ImagePossessable {
    private var imageURL: URL?
    
    var imagePath: String? {
        return self.imageURL?.path
    }
    
    init(id: String, origin: Point, size: Size, image: URL? = nil) {
        super.init(id: id, origin: origin, size: size)
        self.imageURL = image
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, image: URL? = nil) {
        super.init(id: id, x: x, y: y, width: width, height: height)
        self.imageURL = image
    }
    
    func setImage(with url: URL) {
        self.imageURL = url
    }
    
    override func notifyDidCreated() {
        NotificationCenter.default.post(name: .ImageRectangleModelDidCreated, object: self)
    }
}
