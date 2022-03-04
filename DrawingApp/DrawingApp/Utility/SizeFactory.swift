//
//  SizeFactory.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/04.
//

import Foundation

enum SizeFactory: TypeBuilder {
    typealias T = Size
    
    static func makeType() -> Size {
        let range = Size.range
        let width = Double.random(in: range, digits: 2)
        let height = Double.random(in: range, digits: 2)
        
        return Size(width: width, height: height)
    }
}
