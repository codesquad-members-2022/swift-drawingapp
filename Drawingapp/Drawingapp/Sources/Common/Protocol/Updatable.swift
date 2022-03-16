//
//  ChangProtcol.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/15.
//

import Foundation

protocol OriginUpdatable {
    func update(origin: Point)
}

protocol AlphaUpdatable {
    func update(alpha: Alpha)
}

protocol ColorUpdatable {
    func update(color: Color?)
}

protocol FontUpdatable {
    func update(font: Font)
    func update(fontName: String)
    func update(fontSize: Double)
}

protocol TextUpdatable {
    func update(text: String)
}

protocol ImageUpdatable {
    func update(imageUrl: URL?)
}

protocol FrameUpdatable {
    func update(origin: Point)
    func update(size: Size)
}

protocol Transformable {
    func transform(translationX: Double, y: Double)
    func transform(width: Double, height: Double)
}
