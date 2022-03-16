//
//  ImageRectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/15.
//

import Foundation

class ImageRectangle: Rectangle {
    private(set) var image: URL?
    
    init(id: String, origin: Point, size: Size, image: URL? = nil) {
        super.init(id: id, origin: origin, size: size)
        self.image = image
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, image: URL? = nil) {
        super.init(id: id, x: x, y: y, width: width, height: height)
        self.image = image
    }
    
    func setImage(with url: URL) {
        self.image = url
    }
    
    override func notifyDidCreated() {
        NotificationCenter.default.post(name: .ImageRectangleModelDidCreated, object: self)
    }
    
    override func notifyDidUpdated(key: NotificationKey, data: Any) {
        NotificationCenter.default.post(name: .RectangleModelDidUpdated, object: self, userInfo: [key: data])
    }
}
