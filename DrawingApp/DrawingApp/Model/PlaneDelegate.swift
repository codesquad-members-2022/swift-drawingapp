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
    
    func didUpdateRecentlySelectedRectangle(_ rectangle: Rectangle)
    
    func didUpdateRecentlySelectedRectangleBackgroundColor(_ rectangle: Rectangle)
    func didUpdateRecentlySelectedRectangleAlpha(_ rectangle: Rectangle)
}
