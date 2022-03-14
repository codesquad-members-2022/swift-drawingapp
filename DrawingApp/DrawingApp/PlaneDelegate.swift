//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/13.
//

import Foundation

protocol PlaneDelegate {
    /// Plane -> VC에 rectangle 만들었다고 알려줌. VC에서 Plane에 그냥 추가해주는거
    func planeDidAddedRectangle(_ rectangle: Rectangle)
}
