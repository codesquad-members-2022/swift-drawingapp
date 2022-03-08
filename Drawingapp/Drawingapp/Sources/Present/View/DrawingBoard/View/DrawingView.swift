//
//  DrawingView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class DrawingView: UIView {
    let canvasView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
        
    func layout() {
        self.addSubview(canvasView)
        self.canvasView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.canvasView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.canvasView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.canvasView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func update(color: Color?) {
        if let color = color {
            canvasView.backgroundColor = UIColor(red: CGFloat(color.r) / 255, green: CGFloat(color.g) / 255, blue: CGFloat(color.b / 255), alpha: 1)
        } else {
            canvasView.backgroundColor = .clear
        }
    }
    
    func update(alpha: Alpha) {
        canvasView.alpha = alpha.value
    }
    
    func update(point: Point) {
        self.frame = CGRect(x: point.x, y: point.y, width: self.frame.width, height: self.frame.height)
    }
    
    func update(size: Size) {
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: size.width, height: size.height)
    }
    
    func selected(is select: Bool) {
        self.layer.borderWidth = select ? 3 : 0
        self.layer.borderColor = select ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
    }
}
