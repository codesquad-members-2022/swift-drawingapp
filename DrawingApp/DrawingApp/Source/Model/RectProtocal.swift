//
//  RectProtocal.swift
//  DrawingApp
//
//  Created by Jason on 2022/03/30.
//

import Foundation

protocol CreateRandomRect {
    func generateRandomIdentifier() -> Identifier
    func generateRandomSize() -> Size
    func generateRandomPoint() -> Point
    func generateRandomColor() -> BackgroundColor
    func generateRandomAlpha() -> Alpha
    func createRandomRect() -> Rectangle
}
