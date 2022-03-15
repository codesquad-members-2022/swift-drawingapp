//
//  ImagePlane.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/08.
//

import Foundation

final class Image: RectValue, CustomStringConvertible{
    private let image: MyImage
    
    var description: String{
        let description = "[\(image.imageInfo())] : (X: \(point.x), Y:\(point.y)) / (W: \(size.width), H:\(size.height)) / Alpha: \(alpha)"
        return description
    }
    
    init(image: MyImage, id: String, size: MySize, point: MyPoint, alpha: Alpha){
        self.image = image
        super.init(id: id, size: size, point: point, alpha: alpha)
    }
    
    func showMyImage() -> MyImage{
        return image
    }
}
