//
//  RectangleView.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/08.
//

import UIKit


class RectangleView: UIView {
    private var rectData: Rectangle?
    
    convenience init(rect: Rectangle) {
        let origin = CGPoint(x: rect.point.x, y: rect.point.y)
        let size = CGSize(width: rect.size.width, height: rect.size.height)
        let frame = CGRect(origin: origin, size: size)
        self.init(frame: frame)
        self.rectData = rect
        self.backgroundColor = UIColor(color: rect.color)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
