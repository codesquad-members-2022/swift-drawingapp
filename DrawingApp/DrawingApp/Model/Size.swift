//
//  Size.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/02.
//

import Foundation

struct Size {
    static let range = 30.0...100.0
    
    let width: Double
    let height: Double
    
    init(width: Int, height: Int) {
        self.width = Double(width)
        self.height = Double(height)
    }
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
    func convert<T: SizeBuildable>(using Convertor: T.Type) -> T {
        return Convertor.init(width: self.width, height: self.height)
    }
}

extension Size: CustomStringConvertible, Equatable {
    var description: String {
        return "W: \(self.width), H: \(self.height)"
    }
}
