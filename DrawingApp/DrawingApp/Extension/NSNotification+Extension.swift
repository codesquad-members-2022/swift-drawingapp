//
//  NSNotification+Extension.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/29.
//

import Foundation

extension NSNotification.Name {
    /// Plane에서 사각형 생성 시 POST
    static let PlaneDidCreateRectangle = NSNotification.Name("PlaneDidCreateRectangleNotification")
    
    /// Plane에서 터치된 좌표에 사각형 있을 시 POST
    static let PlaneDidTouchRectangle = NSNotification.Name("PlaneDidTouchRectangleNotification")
    
    /// Plane에서 터치된 좌표가 비어있을 시 POST
    static let PlaneDidTouchEmptyView = NSNotification.Name("PlaneDidTouchEmptyViewNotification")
    
    /// Plane에서 색상 변경 시 POST
    static let PlaneDidChangeColor = NSNotification.Name("PlaneDidChangeColorNotification")
    
    /// Plane에서 투명도 변경 시 POST
    static let PlaneDidChangeAlpha = NSNotification.Name("PlaneDidChangeAlphaNotification")
}
