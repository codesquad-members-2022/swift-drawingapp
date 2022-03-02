//
//  Alpha.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import Foundation

enum Alpha: Double, CaseIterable{
    case one = 0.1
    case two = 0.2
    case three = 0.3
    case four = 0.4
    case five = 0.5
    case six = 0.6
    case seven = 0.7
    case eight = 0.8
    case nine = 0.9
    case ten = 1
    
    func showValue() -> Double{
        return self.rawValue
    }
}
