//
//  Labelable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol Labelable: Drawingable {
    var font: Font { get }
    var text: String { get }
    func update(fontName: String)
}
