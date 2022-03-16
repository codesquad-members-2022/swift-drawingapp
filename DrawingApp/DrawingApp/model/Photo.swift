//
//  Photo.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/14.
//

import Foundation

class Photo: CustomViewModel{
    private var imageData: Data
    init(imageData: Data, uniqueId: String, point: ViewPoint, size: ViewSize, alpha: Double){
        self.imageData = imageData
        super.init(uniqueId: uniqueId, point: point, size: size, alpha: alpha)
    }
}
extension Photo: PhotoViewModelMutable{
    func getImageData() -> Data {
        return imageData
    }
}

protocol PhotoViewModelMutable: CustomViewModelMutable{
    func getImageData() -> Data
}
