//
//  PointFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/03.
//

import Foundation
import UIKit

class PointFactory {
    func make() -> Point {
        let screenSize = UIScreen.main.bounds.size
        let pointX = Int.random(in: 0..<Int(screenSize.width))
        let pointY = Int.random(in: 0..<Int(screenSize.height))
        return Point(x: pointX, y: pointY)
    }
}
