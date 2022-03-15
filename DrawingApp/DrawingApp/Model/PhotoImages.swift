//
//  PhotoImage.swift
//  DrawingApp
//
//  Created by dale on 2022/03/14.
//

import Foundation

protocol PhotoImagesDelegate {
    func photoImages(didAdd data: Data)
}

class PhotoImages {
    private var imageDatas : [Data] = []
    var deleagate : PhotoImagesDelegate?
    
    subscript(index: Int) -> Data? {
        if index < imagesCount {
            let targetImage = imageDatas[index]
            return targetImage
        }
        return nil
    }
    
    var imagesCount : Int {
        return imageDatas.count
    }
    
    func addImage(by data: Data) {
        self.imageDatas.append(data)
        deleagate?.photoImages(didAdd: data)
    }
}
