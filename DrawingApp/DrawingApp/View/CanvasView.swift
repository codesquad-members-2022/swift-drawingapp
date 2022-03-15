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

    private var touchPositionOfX = 0.0
    private var touchPositionOfY = 0.0
    
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
        let myView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        myView.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue())
        addSubview(myView)
    }
    
    func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let log = Logger()
        log.info("좌표 X: \(self.touchPositionOfX), Y: \(self.touchPositionOfY)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = event?.allTouches?.first {
            let loc: CGPoint = touch.location(in: touch.view)
            
            touchPositionOfX = loc.x
            touchPositionOfY = loc.y
        }
    }
}
