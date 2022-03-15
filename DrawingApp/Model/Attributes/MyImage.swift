//
//  MyImage.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/08.
//

import Foundation
import UIKit

struct MyImage: Equatable{
    private let image: UIImage
    
    func showUIImage() -> UIImage{
        return image
    }
    
    func imageInfo() -> String{
        image.description
    }
    
    init(image: UIImage){
        self.image = image
    }
}
