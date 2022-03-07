//
//  BackgroundColor.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import Foundation

class BackgroundColor {
    private let red: Int
    private let green: Int
    private let blue: Int
    
    init(R: Int, G: Int, B: Int) {
        self.red = R
        self.green = G
        self.blue = B
    }
}

extension BackgroundColor: CustomStringConvertible {
    var description: String {
        return "R:\(self.red), G:\(self.green), B:\(self.blue)"
    }
}

