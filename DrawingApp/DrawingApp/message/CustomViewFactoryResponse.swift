//
//  MoveRectangle.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

protocol CustomViewFactoryResponse{
    func randomRectangleViewModel() -> RectangleViewModelMutable
    func randomPhotoViewModel(imageData: Data) -> PhotoViewModelMutable
}
