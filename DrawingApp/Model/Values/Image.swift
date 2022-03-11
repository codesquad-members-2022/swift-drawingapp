//
//  ImagePlane.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/08.
//

import Foundation

final class Image: RectValue, Hashable, CustomStringConvertible{
    let image: MyImage
    
    var description: String{
        let description = "[\(image.imageInfo())] : (X: \(point.x), Y:\(point.y)) / (W: \(size.width), H:\(size.height)) / Alpha: \(alpha)"
        return description
    }
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.id == rhs.id && lhs.image == rhs.image && lhs.size == rhs.size && lhs.point == rhs.point && lhs.alpha == rhs.alpha
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(id):\(madeTime)")
    }
    
    init(image: MyImage, id: String, size: MySize, point: MyPoint, alpha: Alpha){
        self.image = image
        super.init(id: id, size: size, point: point, alpha: alpha)
    }
}
