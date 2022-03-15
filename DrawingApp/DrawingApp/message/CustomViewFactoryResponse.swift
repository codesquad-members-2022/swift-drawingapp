//
//  MoveRectangle.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

protocol CustomViewFactoryResponse{
    func randomRectangle() -> RectangleMutable
    func randomRGBColor() -> RGBColorMutable
    func randomPhoto(imageData: Data) -> PhotoMutable
}
