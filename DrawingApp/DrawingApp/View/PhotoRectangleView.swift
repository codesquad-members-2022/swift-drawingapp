//
//  PhotoRectangleView.swift
//  DrawingApp
//
//  Created by dale on 2022/03/14.
//

import UIKit

class PhotoRectangleView: RectangleView {
    var photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    convenience init(from rectangleFrame: CGRect, image: UIImage, alpha: Alpha) {
        self.init(frame: rectangleFrame)
        setImage(image: image)
        setAlpha(alpha: alpha)
    }
    
    func setImage(image : UIImage) {
        self.photoImageView.image = image
        self.addSubview(photoImageView)
        photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
}
