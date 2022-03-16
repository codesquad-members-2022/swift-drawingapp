//
//  Colorable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol Colorable: Drawingable, ColorUpdatable {
    var color: Color { get }
}
