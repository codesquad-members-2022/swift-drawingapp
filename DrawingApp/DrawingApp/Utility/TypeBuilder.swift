//
//  TypeBuilder.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/04.
//

import Foundation

protocol TypeBuilder {
    associatedtype T
    static func makeType() -> T
}
