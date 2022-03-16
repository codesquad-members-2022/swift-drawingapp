//
//  ImageRectangleView.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/16.
//

import UIKit

class ImageRectanlgeView:UIImageView,RectangleViewable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupFrameWithRectangle(rect:Rectangleable) {
        guard let planeRectangle = (rect as? PlaneRectangle) else { return }
        let x = planeRectangle.origin.x
        let y = planeRectangle.origin.y
        let width = planeRectangle.size.width
        let height = planeRectangle.size.height
        self.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    //image name for test
    func setupImage(imageData:Data) {
        self.image = UIImage(data: imageData)
    }
    
}
