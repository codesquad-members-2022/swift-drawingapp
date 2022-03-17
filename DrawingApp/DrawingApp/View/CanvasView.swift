//
//  CanvasView.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/11.
//

import Foundation
import os
import UIKit

/// 사각형이 그려지는 뷰
class CanvasView: UIView {
    var delegate: CanvasViewDelegate?
    private var rectangles = [Rectangle: RectangleView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        setTapGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        
        setTapGesture()
    }
    
    func drawRectangle(rectangle: Rectangle) {
        // 받은 직사각형을 CanvasView에 그려주기
        let rectangleView = RectangleView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        rectangleView.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue())
        rectangleView.alpha = rectangle.alpha.opacity
        addSubview(rectangleView)
        rectangles[rectangle] = rectangleView
    }
    
    func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)
    }
    
    func select(rectangle: Rectangle) {
        for (key, value) in rectangles {
            if key == rectangle {
                initializeRectangle()
                value.layer.borderWidth = 3
                value.layer.borderColor = UIColor.blue.cgColor
                value.layer.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue()).cgColor
                return
            }
        }
    }
    
    func initializeRectangle() {
        for (_, value) in rectangles {
            value.layer.borderWidth = 0
        }
    }
    
    func changeRectangle(_ rectangle: Rectangle) {
        for (key, value) in rectangles {
            if key == rectangle {
                value.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue())
            }
        }
    }
}



extension CanvasView: UIGestureRecognizerDelegate {
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let positionOfCanvasView = gestureRecognizer.location(in: gestureRecognizer.view) // CanvasView에서 터치되는 좌표
        delegate?.canvasViewDidTouched(x: positionOfCanvasView.x, y: positionOfCanvasView.y)
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        if let touch = event.allTouches?.first {
            // CanvasView 내부의 뷰에서 터치되는 좌표. 만약 직사각형이 있으면 그 내부에서의 좌표. 아무것도 없다면 CanvasView에서의 터치 좌표
            let positionOfSubview = touch.location(in: touch.view)
            let view = touch.view // CanvasView 내부의 뷰
            
        }
        return true
    }
}
