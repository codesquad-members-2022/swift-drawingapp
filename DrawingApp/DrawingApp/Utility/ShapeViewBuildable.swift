//
//  ShapeViewBuildable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/18.
//

import Foundation


protocol ShapeViewBuildable {
    static func makeView(ofClass type: ShapeViewable.Type, with data: Shapable) -> ShapeViewable?
}
