//
//  PhotoView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/04.
//

import Foundation
import UIKit

class PhotoView: DrawingView {
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init(model: DrawingModel) {
        super.init(model: model)
        if let imageable = model as? Imageable {
            self.update(imageUrl: imageable.imageUrl)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layout() {
        super.layout()
        self.canvasView.addSubview(photoView)
        self.photoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.photoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.photoView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.photoView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func update(imageUrl : URL?) {
        guard let url = imageUrl else {
            return
        }
        self.photoView.image = UIImage(contentsOfFile: url.path) 
    }
}
