//
//  PhotoModel.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/08.
//

import Foundation

class PhotoModel: DrawingModel {
    public private(set) var imageUrl: URL?
    
    override var description: String {
        "id: ( \(id) ), \(point), \(size), alpha: \(alpha), url: \(imageUrl)"
    }
    
    init(id: String, point: Point, size: Size, alpha: Alpha, url: URL) {
        self.imageUrl = url
        super.init(id: id, point: point, size: size, color: nil, alpha: alpha)
    }
    
    func update(url: URL) {
        self.imageUrl = url
        let userInfo: [AnyHashable : Any] = [ParamKey.imageUrl:url]
        NotificationCenter.default.post(name: NotifiName.updateImageUrl, object: self, userInfo: userInfo)
    }
    
    override func update(color: Color) {
        return
    }
}
