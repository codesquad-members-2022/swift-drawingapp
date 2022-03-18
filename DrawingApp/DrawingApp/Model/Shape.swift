//
//  Shape.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/18.
//

import Foundation

typealias NotifiableShape = Shape & Notifiable
typealias AlphaAdaptableShape = Shape & AlphaAdaptable
typealias BackgroundAdaptableShape = Shape & BackgroundAdaptable

/// 추상 클래스
class Shape: Shapable, Hashable {
    let id: String
    let size: Size
    let origin: Point
    
    init(id: String, origin: Point, size: Size) {
        self.id = id
        self.origin = origin
        self.size = size
    }
}
