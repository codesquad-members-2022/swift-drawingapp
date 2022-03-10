//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import Foundation

protocol PlaneDelegate {
    func planeDidAddRectangle(_ plane: Plane)
    func planeDidSpecifyRectangle(_ plane: Plane)
    func planeDidChangeBackgroundColorOfRectangle(_ plane: Plane)
    func planeDidChangeAlphaOfRectangle(_ plane: Plane)
}
