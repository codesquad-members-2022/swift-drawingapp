//
//  Shapable.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

protocol Shapable: CustomStringConvertible {
    var id: Identifier { get }
    var size: Size { get }
    var point: Point { get }
    var backGroundColor: Color { get }
}

extension Shapable {
    var description: String {
        return "(\(self.id)), \(self.point), \(self.size), \(self.backGroundColor)"
    }
}
