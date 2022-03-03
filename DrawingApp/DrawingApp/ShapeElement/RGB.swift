//
//  RGB.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//


final class RGB:CustomStringConvertible{
    
    var description: String {
        "R:\(red), G:\(green), B:\(blue)"
    }
    
    //min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let minValue: Double = 0
    static let maxValue: Double = 255
    
    private var inputRedValue:Double
    private var inputGreenValue:Double
    private var inputBlueValue:Double
    

    var red:Double { self.translateInputRGBValue(inputValue: inputRedValue) }
    var green:Double { self.translateInputRGBValue(inputValue: inputGreenValue) }
    var blue:Double { self.translateInputRGBValue(inputValue: inputBlueValue) }
    
    
    init(red:Double,green:Double,blue:Double) {
        self.inputRedValue = red
        self.inputGreenValue = green
        self.inputBlueValue = blue
    }
    
    
    //가장큰값 maxValue보다 크면 maxValue로 가작 작은값 minValue보다 작으면 minValue를 주도록 했습니다.
    private func translateInputRGBValue(inputValue:Double) -> Double{
        
        if inputValue < RGB.minValue {
            return RGB.minValue
        } else if inputValue > RGB.maxValue {
            return RGB.maxValue
        } else {
            return inputValue
        }
        
    }
    
    
}
