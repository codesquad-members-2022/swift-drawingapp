//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

protocol PlaneDelegate {
    func rectangleDidAdded(_ rectangle: Rectangle)
    func rectangleDidSpecified(_ rectangle: Rectangle)
    func rectangleBackgroundColorDidChanged(_ rectangle: Rectangle)
    func rectangleAlphaDidChanged(_ rectangle: Rectangle)
}
