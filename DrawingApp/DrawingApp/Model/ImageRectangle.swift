//
//  ImageRectangle.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/15.
//

import Foundation

typealias ImageControllable = ImageAdaptable & AlphaAdaptable

class ImageRectangle: Shape, ImageControllable, Notifiable {
    private(set) var alpha: Alpha {
        didSet {
            self.notifyDidUpdated(key: .updated, data: self.alpha)
        }
    }
    
    private var imageURL: URL?
    
    var imagePath: String? {
        return self.imageURL?.path
    }
    
    init(id: String, origin: Point, size: Size, image: URL? = nil) {
        self.imageURL = image
        self.alpha = .opaque
        super.init(id: id, origin: origin, size: size)
    }
    
    init(id: String, x: Double, y: Double, width: Double, height: Double, image: URL? = nil) {
        let origin = Point(x: x, y: y)
        let size = Size(width: width, height: height)
        self.imageURL = image
        self.alpha = .opaque
        super.init(id: id, origin: origin, size: size)
    }
    
    func setImagePath(with url: URL) {
        self.imageURL = url
    }
    
    func setAlpha(_ alpha: Alpha) {
        self.alpha = alpha
    }
    
    func convert<T: RectangleBuildable>(using Convertor: T.Type) -> T {
        return Convertor.init(x: self.origin.x, y: self.origin.y, width: self.size.width, height: self.size.height)
    }
    
    func notifyDidCreated() {
        NotificationCenter.default.post(name: .ImageRectangleModelDidCreated, object: self)
    }
    
    func notifyDidUpdated(key: NotificationKey, data: Any) {
        NotificationCenter.default.post(name: .RectangleModelDidUpdated, object: self, userInfo: [key: data])
    }
}
