//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import Foundation
import UIKit

class RectangleView: CustomBaseView{
    override init(size: ViewSize, point: ViewPoint){
        super.init(size: size, point: point)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension RectangleView: RectangleViewSetable{
    func setRGBColor(rgb: ColorRGB){
        backgroundColor = UIColor(cgColor: CGColor(red: CGFloat(rgb.r)/255, green: CGFloat(rgb.g)/255, blue: CGFloat(rgb.b)/255, alpha: 1))
    }
}

protocol RectangleViewSetable: CustomBaseViewSetable{
    func setRGBColor(rgb: ColorRGB)
}
