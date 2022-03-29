//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/13.
//

import Foundation

protocol PlaneDelegate {
    /// Plane에서 사각형의 색상이 변경되었음을 VC에게 알림 (출력: Model -> VC)
    func planeDidChangedColor(of rectangle: Rectangle)
    
    /// Plane에서 사각형의 투명도가 변경되었음을 VC에게 알림 (출력: Model -> VC)
    func planeDidChangedAlpha(of rectangle: Rectangle)
}
