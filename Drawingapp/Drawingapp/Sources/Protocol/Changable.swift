//
//  ChangProtcol.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/15.
//

import Foundation

protocol AlphaChangable {
    func changeAlpha(_ alpha: Alpha)
}

protocol ColorChangable {
    func changeColor(_ color: Color)
}

protocol FontChangable {
    func changeFontName(_ fontName: String)
}

protocol Transformable {
    func transform(translationX: Double, y: Double)
    func transform(width: Double, height: Double)
}

protocol Changable: AlphaChangable, ColorChangable, FontChangable, Transformable {
}
