//
//  ChangProtcol.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/15.
//

import Foundation

protocol AlphaUpdatable {
    func update(alpha: Alpha)
}

protocol ColorUpdatable {
    func update(color: Color)
}

protocol FontUpdatable {
    func update(fontName: String)
}

protocol ImageUpdatable {
    func update(imageUrl: URL?)
}

protocol Transformable {
    func transform(translationX: Double, y: Double)
    func transform(width: Double, height: Double)
}
