//
//  PhotoRectangleView.swift
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
    
    
    override func layout() {
        super.layout()
        self.canvasView.addSubview(photoView)
        self.photoView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.photoView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.photoView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.photoView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func update(imageURL: URL) {
        let data = try? Data(contentsOf: imageURL)
        guard let data = data,
            let image = UIImage(data: data) else {
            return
        }
        self.photoView.image = image
    }
    
    func update(itemProvider: NSItemProvider) {
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    self.photoView.image = image as? UIImage
                }
            }
        }
    }
}
