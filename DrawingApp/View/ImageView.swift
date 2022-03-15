//
//  ImageView.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/08.
//

import Foundation
import UIKit

final class ImageView: UIImageView, NSCopying{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let imageView = ImageView(frame: self.frame)
        imageView.image = self.image
        imageView.alpha = 0.5
        return imageView
    }
}
