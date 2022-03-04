//
//  Shapable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/03.
//

import Foundation

protocol Shapable: CustomStringConvertible {
    var id: String { get }
    var size: Size { get }
    var origin: Point { get }
    var backgroundColor: Color { get }
    var alpha: Alpha { get }
}
