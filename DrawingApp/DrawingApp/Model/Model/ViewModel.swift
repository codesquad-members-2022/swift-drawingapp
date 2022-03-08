//
//  ViewModel.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/07.
//

import Foundation

protocol ViewModel {
    var id: ID { get }
    var center: Point { get }
    var origin: Point { get }
    var size: Size { get }
    
    func contains(_ point: Point) -> Bool
}

protocol ColorMutable {
    var color: Color { get }
    func transform(to color: Color)
}

protocol AlphaMutable {
    var alpha: Alpha { get }
    func transform(to alpha: Alpha)
}

protocol OriginMutable {
    var origin: Point { get }
    func transform(to origin: Point)
}
