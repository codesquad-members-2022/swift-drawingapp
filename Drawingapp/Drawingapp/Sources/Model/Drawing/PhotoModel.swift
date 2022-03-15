//
//  PhotoModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

class PhotoModel: DrawingModel, Imageable, Viewable {
    public private(set) var imageUrl: URL?
    
    override var description: String {
        "id: ( \(id) ), \(origin), \(size), alpha: \(alpha), url: \(imageUrl)"
    }
    
    var displayName: String {
        "Photo \(index)"
    }
    
    var iconName: String {
        "ic_photo"
    }
    
    init(id: String, index: Int, origin: Point, size: Size, alpha: Alpha, url: URL?) {
        self.imageUrl = url
        super.init(id: id, index: index, origin: origin, size: size, alpha: alpha)
    }
    
    func update(imageUrl: URL?) {
        guard let imageUrl = imageUrl else {
            return
        }
        self.imageUrl = imageUrl
    }
}
