//
//  Colorable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol Colorable: Drawingable {
    var color: Color { get }
    func update(color: Color)
}
