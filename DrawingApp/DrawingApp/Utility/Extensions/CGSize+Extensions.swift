//
//  CGSize+Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/09.
//

import UIKit

protocol SizeBuildable {
    init(width: Double, height: Double)
}

extension CGSize {
    init(with size: Size) {
        self.init(width: size.width, height: size.height)
    }
    
    func convert<T: SizeBuildable>(using Convertor: T.Type) -> T {
        return Convertor.init(width: self.width, height: self.height)
    }
}
