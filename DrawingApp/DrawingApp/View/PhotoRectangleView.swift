//
//  PhotoRectangleView.swift
//  DrawingApp
//
//  Created by dale on 2022/03/14.
//

import UIKit

class PhotoRectangleView: UIView, ShapeViewAble {
    private var photoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = UIColor.blue.cgColor
        return imageView
    }()
    
    init(from rectangleFrame: CGRect, imageData: Data, alpha: Alpha) {
        super.init(frame: rectangleFrame)
        layoutImageView()
        setImage(imageData: imageData)
        setAlpha(alpha: alpha)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func layoutImageView() {
        self.addSubview(photoImageView)
        photoImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        photoImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func borderVisible(_ enable : Bool) {
        self.layer.borderWidth = enable ? 2 : 0
    }
    
    func setAlpha(alpha: Alpha) {
        self.alpha = alpha.transparency
    }
    
    func setImage(imageData : Data) {
        self.photoImageView.image = UIImage(data: imageData)
    }
}
