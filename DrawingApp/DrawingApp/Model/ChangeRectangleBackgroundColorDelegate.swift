//
//  ChangeRectangleBackgroundColorDelegate.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/06.
//

import Foundation

protocol ChangeRectangleBackgroundColorDelegate {
    func rectangleDidChangeBackgroundColor(to newColor: BackgroundColor, alpha: Alpha)
}
