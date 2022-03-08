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
    
    init(point: Point, size: Size, alpha: Alpha, imageUrl: URL?) {
        super.init(frame: CGRect(x: point.x, y: point.y, width: size.width, height: size.height))
        self.update(alpha: alpha)
        self.update(imageURL: imageUrl)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    override func layout() {
        super.layout()
        self.canvasView.addSubview(photoView)
        self.photoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.photoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.photoView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.photoView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func update(imageURL: URL?) {
        guard let url = imageURL else {
            return
        }
        self.photoView.image = UIImage(contentsOfFile: url.path)
    }
}
