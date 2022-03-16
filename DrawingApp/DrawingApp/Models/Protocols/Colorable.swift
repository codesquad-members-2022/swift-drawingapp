//
//  Colorable.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import Foundation

protocol Colorable {
    var backgroundColor: Color { get }
    func changeBackgroundColor(by backgroundColor: Color)
}

extension Colorable {
    var hexaValue: String {
        let red = Int(backgroundColor.red)
        let green = Int(backgroundColor.green)
        let blue = Int(backgroundColor.blue)
        
        return "\(String(format: "#%02X%02X%02X", red, green, blue))"
    }
}
