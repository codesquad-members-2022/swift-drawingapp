//
//  PlaneDelegate.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/04.
//

import Foundation

protocol PlaneDelegate {
    func didCreateShape(_ shape: BasicShape)
    
    func didSelectShape(_ shape: BasicShape)
    func didSelectEmptyView()
    
    func didChangeSelectedShape(_ shape: BasicShape)
    
    func didUpdateSelectedShapeBackgroundColor(_ shape: BasicShape & Colorable)
    func didUpdateSelectedShapeAlpha(_ shape: BasicShape & Alphable)
}
