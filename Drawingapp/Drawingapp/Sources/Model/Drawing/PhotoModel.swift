//
//  PhotoModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

class PhotoModel: DrawingModel, Imageable {
    public private(set) var imageUrl: URL?
    
    override var description: String {
        "id: ( \(id) ), \(origin), \(size), alpha: \(alpha), url: \(imageUrl)"
    }
    
    init(id: String, origin: Point, size: Size, alpha: Alpha, url: URL) {
        self.imageUrl = url
        super.init(id: id, origin: origin, size: size, alpha: alpha)
    }
    
    func update(imageUrl: URL?) {
        guard let imageUrl = imageUrl else {
            return
        }
        
        self.imageUrl = imageUrl
        let userInfo: [AnyHashable : Any] = [ParamKey.imageUrl:imageUrl]
        NotificationCenter.default.post(name: NotifiName.updateImageUrl, object: self, userInfo: userInfo)
    }
}
