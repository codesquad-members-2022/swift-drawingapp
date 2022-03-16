//
//  Drawingable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol Drawingable: OriginUpdatable, Transformable, AlphaUpdatable {
    var origin: Point { get }
    var size: Size { get }
    var alpha: Alpha { get }
}
