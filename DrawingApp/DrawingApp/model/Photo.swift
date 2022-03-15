//
//  Photo.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/14.
//

import Foundation

class Photo: CustomViewEntity{
    private(set) var imageData: Data
    init(imageData: Data, uniqueId: String, point: ViewPoint, size: ViewSize, alpha: Double){
        self.imageData = imageData
        super.init(uniqueId: uniqueId, point: point, size: size, alpha: alpha)
    }
}
extension Photo: PhotoMutable{
    func getRandomPhoto() -> Photo {
        return self
    }
}
