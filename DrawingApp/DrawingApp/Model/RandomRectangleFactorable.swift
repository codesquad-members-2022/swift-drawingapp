//
//  RandomRectangleFactorable.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/03.
//

import Foundation

protocol RandomRectangleFactorable {
    func generateRandomIdentifier(delimiter: Character) -> Identifier
    func generateRandomSize() -> Size
    func generateRandomPoint() -> Point
    func generateRandomColor() -> Color
    
    func createRandomShape() -> Shapable
}
