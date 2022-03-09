//
//  Photo.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/07.
//

import Foundation

class Photo: ViewModel {
    
    private(set) var data: Data
    private(set) var alpha: Alpha

    init(id: ID, origin: Point, size: Size, photo: Data, alpha: Alpha) {
        self.data = photo
        self.alpha = alpha
        super.init(id: id, origin: origin, size: size)
    }
    
    static func random(from data: Data) -> Photo {
        let photoID = ID.random()
        let origin = Point.random()
        let size = Size.standard()
        let alpha = Alpha.random()
        
        return Photo(id: photoID, origin: origin, size: size, photo: data, alpha: alpha)
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
