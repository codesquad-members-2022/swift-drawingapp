//
//  RandomRectangle.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import UIKit

final class RectangleView: UIView, NSCopying{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let rectangleView = RectangleView(frame: self.frame)
        rectangleView.backgroundColor = self.backgroundColor
        rectangleView.backgroundColor?.withAlphaComponent(1)
        return rectangleView
    }
}
