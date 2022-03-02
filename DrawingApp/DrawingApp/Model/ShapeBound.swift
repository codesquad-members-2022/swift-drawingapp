//
//  ShapeBound.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/01.
//

import Foundation

enum ShapeBound {
    enum Id {
        static let alphaNumeric = "abcdefghijklmnopqrstuvxyz0123456789"
        static let tokenLength = 3
    }
    
    enum Size {
        static let lowwer = 0.0
        static let upper = 100.0
    }
    
    enum Point {
        static let lowwer = 0.0
        static let upper = 100.0
    }
    
    enum Color {
        static let lowwer = 0.0
        static let upper = 255.0
    }
}
