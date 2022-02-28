//
//  Attributes.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import Foundation

struct MySize{
    private let width: Double
    private let height: Double
    
    func widthValue() -> Double{
        return self.width
    }
    
    func heightValue() -> Double{
        return self.height
    }
    
    init(width: Double, height: Double){
        self.width = width
        self.height = height
    }
}

struct MyPoint{
    private let x: Double
    private let y: Double
    
    func xValue() -> Double{
        return self.x
    }
    
    func yValue() -> Double{
        return self.y
    }
    
    init(x: Double, y: Double){
        self.x = x
        self.y = y
    }
}

struct RGBColor{
    private let red: Double
    private let green: Double
    private let blue: Double
    
    func redValue() -> Double{
        return self.red
    }
    
    func greenValue() -> Double{
        return self.green
    }
    
    func blueValue() -> Double{
        return self.blue
    }
    
    init(red: Double, green: Double, blue: Double){
        self.red = red
        self.green = green
        self.blue = blue
    }
}

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
