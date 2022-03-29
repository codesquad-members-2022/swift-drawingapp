//
//  PictureView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/29.
//

import UIKit

class PictureView: BasicShapeView {
    
    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    init(point: Point, size: Size, alpha: Alpha, imageBinaryData: Data) {
        super.init(point: point, size: size)
        self.changeAlpha(to: alpha)
        self.changePicture(by: imageBinaryData)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension PictureView: ViewAlphaChangable {
    func changeAlpha(to alphaLevel: Alpha) {
        alpha = alphaLevel.value
    }
}

extension PictureView: ViewPictureChangable {
    func changePicture(by imageBinaryData: Data) {
        let image = UIImage(data: imageBinaryData)
        pictureImageView.image = image
        addSubview(pictureImageView)
        pictureImageView.frame = self.bounds
    }
}
