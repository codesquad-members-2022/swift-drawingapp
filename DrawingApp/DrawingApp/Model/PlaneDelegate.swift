//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/04.
//

import Foundation

protocol PlaneDelegate {
    func didCreateRectangle(_ rectangle: Rectangle)
    func didSelectRectanlge(_ rectangle: Rectangle)
    func didSelectEmptyView()
    
    func didUpdateSelectedRectangle(_ rectangle: Rectangle)
    
    func didUpdateSelectedRectangleBackgroundColor(_ rectangle: Rectangle)
    func didUpdateSelectedRectangleAlpha(_ rectangle: Rectangle)
}
