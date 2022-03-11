//
//  ImagePlane.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/08.
//

import Foundation

final class Image: RectValue, CustomStringConvertible{
    let image: MyImage
    let madeTime = Date()
    private(set) var size: MySize
    private(set) var point: MyPoint
    private(set) var alpha: Alpha
    
    var description: String{
        let description = "[\(image.imageInfo())] : (X: \(point.x), Y:\(point.y)) / (W: \(size.width), H:\(size.height)) / Alpha: \(alpha)"
        return description
    }
    
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.image == rhs.image && lhs.size == rhs.size && lhs.point == rhs.point && lhs.alpha == rhs.alpha
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine("\(image):\(madeTime)")
    }
    
    func changeAlpha(alpha: Alpha){
        self.alpha = alpha
    }
    
    func findLocationRange(xPoint: Double, yPoint: Double) -> Bool{
        let minX: Double = self.point.x
        let maxX: Double = minX + self.size.width
        let minY: Double = self.point.y
        let maxY: Double = minY + self.size.height
        
        return xPoint >= minX && xPoint <= maxX && yPoint >= minY && yPoint <= maxY
    }
    
    init(image: MyImage, size: MySize, point: MyPoint, alpha: Alpha){
        self.image = image
        self.size = size
        self.point = point
        self.alpha = alpha
    }
}
