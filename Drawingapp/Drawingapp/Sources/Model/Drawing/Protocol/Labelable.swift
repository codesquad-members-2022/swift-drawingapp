//
//  Labelable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol Labelable: Drawingable, FontUpdatable {
    var font: Font { get }
    var text: String { get }
}
