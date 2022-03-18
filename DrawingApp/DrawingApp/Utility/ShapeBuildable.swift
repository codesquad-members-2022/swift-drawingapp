//
//  ShapeBuildable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/18.
//

import Foundation

protocol ShapeBuildable {
    static func makeShape(ofClass type: Shapable.Type) -> Shapable?
}
