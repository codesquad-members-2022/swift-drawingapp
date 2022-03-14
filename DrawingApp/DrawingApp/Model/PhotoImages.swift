//
//  PhotoImage.swift
//  DrawingApp
//
//  Created by dale on 2022/03/14.
//

import Foundation
import UIKit

protocol PhotoImagesDelegate {
    func photoImages(didAdd image: UIImage)
}

class PhotoImages {
    private var images : [UIImage] = []
    var deleagate : PhotoImagesDelegate?
    
    subscript(index: Int) -> UIImage? {
        if index < imagesCount {
            let targetImage = images[index]
            return targetImage
        }
        return nil
    }
    
    var imagesCount : Int {
        return images.count
    }
    
    func addImage(image: UIImage) {
        self.images.append(image)
        deleagate?.photoImages(didAdd: image)
    }
}
