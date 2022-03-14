//
//  CanvasView.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/11.
//

import Foundation
import UIKit

/// 사각형이 그려지는 뷰
class CanvasView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func drawRectangle(rectangle: Rectangle) {
        // 받은 직사각형을 CanvasView에 그려주기
        let myView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        myView.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue())
        addSubview(myView)
    }
}
