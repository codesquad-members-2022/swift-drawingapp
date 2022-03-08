//
//  CavasView.swift
//  DrawingApp
//
//  Created by dale on 2022/03/08.
//

import UIKit

class RectangleView: UIView {
    var id :Id?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(from rectangle: Rectangle) {
        self.init()
        initialSetUp(rectangle: rectangle)
    }
    
    func initialSetUp(rectangle: Rectangle) {
        self.id = rectangle.id
        let size = rectangle.size
        let position = rectangle.position
        let color = rectangle.backGroundColor
        let alpha = rectangle.alpha
        self.frame = CGRect(x: position.x , y: position.y, width: size.width, height: size.height)
        setBackgroundColor(color: color)
        self.alpha = alpha.transparency
    }
    
    func setAlpha(alpha: Alpha) {
        self.alpha = alpha.transparency
    }
    
    func setBackgroundColor(color : Color) {
        self.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
    }
}
