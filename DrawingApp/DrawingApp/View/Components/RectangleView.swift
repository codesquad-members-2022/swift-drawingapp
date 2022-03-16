//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/07.
//

import UIKit

class RectangleView: UIView, RectangleShapable {
    // MARK: - Initialisers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(with rectangle: Rectangle) {
        self.init(frame: rectangle.convert(using: CGRect.self))
        self.setBackgroundColor(color: rectangle.backgroundColor, alpha: rectangle.alpha)
    }
    
    func setAlpha(_ alpha: Alpha) {
        self.setBackgroundColor(with: alpha)
    }
}
