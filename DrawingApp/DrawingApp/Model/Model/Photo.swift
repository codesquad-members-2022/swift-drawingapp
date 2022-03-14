//
//  Photo.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/07.
//

import Foundation

class Photo: Layer {
    
    private(set) var data: Data
    private(set) var alpha: Alpha

    init(title: String, id: ID, origin: Point, size: Size, photo: Data, alpha: Alpha) {
        self.data = photo
        self.alpha = alpha
        super.init(title: title, id: id, origin: origin, size: size)
    }
}

extension Photo: AlphaMutable {
    func set(to alpha: Alpha) {
        self.alpha = alpha
    }
}
    
extension Photo: CustomStringConvertible {
    var description: String {
        return "(\(id)), \(origin), \(size), \(data), \(alpha)"
    }
}
