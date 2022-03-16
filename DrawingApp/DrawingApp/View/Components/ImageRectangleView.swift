//
//  ImageRectangleView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/15.
//

import UIKit

class ImageRectangleView: UIView, RectangleShapable {
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
    
    func setImage(_ image: UIImage) {
        self.imageView.image = image
    }
    
    func setBackgroundColor(color: Color, alpha: Alpha) {
        return
    }
}
