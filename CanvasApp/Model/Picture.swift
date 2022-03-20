//
//  Picture.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/18.
//

import Foundation
import CoreGraphics

class Picture : BaseRect, PictureAccessable, RectAlphaful, ObjectDescription {
    private(set) var media : URL
    private(set) var alpha : RectAlpha
    
    init(origin: CGPoint = CGPoint.zero,
         size: CGSize = CGSize.zero,
         media: URL,
         alpha: RectAlpha = .ten,
         sequence: Int = 1) {
        self.alpha = RectAlpha.ten
        self.media = media
        super.init(origin: origin, size: size, sequence: sequence)
    }

    func changeAlpha(to value: RectAlpha) {
        self.alpha = value
    }

    var text: String {
        return "Picture-\(sequence)"
    }
    
    var imageName: String {
        return "Picture.png"
    }
}
