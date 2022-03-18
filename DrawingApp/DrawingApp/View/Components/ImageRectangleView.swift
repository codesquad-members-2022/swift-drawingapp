//
//  ImageRectangleView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/15.
//

import UIKit

protocol ImageViewable {
    func setImage(_ image: UIImage)
}

class ImageRectangleView: UIView {
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureImageView()
    }
    
    private func configureImageView() {
        self.imageView.frame = self.bounds
        self.addSubview(imageView)
    }
}

// MARK: - ShapeViewable
extension ImageRectangleView: ShapeViewable {
    func setAlpha(_ alpha: Alpha) {
        self.alpha = alpha.convert(using: CGFloat.self)
    }
}

// MARK: - ImageViewable Protocol
extension ImageRectangleView: ImageViewable {
    func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
}
