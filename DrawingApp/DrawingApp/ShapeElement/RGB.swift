//
//  RGB.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/01.
//


final class RGB{
    
    //min과 max는 타입 자체와 관련이 있기 때문에 Static으로 선언했습니다.
    static let minValue: Int = 0
    static let maxValue: Int = 255
    
    private var inputRedValue:Int
    private var inputGreenValue:Int
    private var inputBlueValue:Int
    
    var red:Int { self.translateInputRGBValue(inputValue: inputRedValue) }
    var green:Int { self.translateInputRGBValue(inputValue: inputGreenValue) }
    var blue:Int { self.translateInputRGBValue(inputValue: inputBlueValue) }
    
    var hexValue:String  { "#" + String(format:"%02X", red) + String(format:"%02X", green) + String(format:"%02X", blue)  }
    
    
    init(red:Int,green:Int,blue:Int) {
        self.inputRedValue = red
        self.inputGreenValue = green
        self.inputBlueValue = blue
    }
    
    static func random() -> RGB {
        let randomRed = Int.random(in: RGB.minValue...RGB.maxValue)
        let randomGreen = Int.random(in: RGB.minValue...RGB.maxValue)
        let randomBlue = Int.random(in: RGB.minValue...RGB.maxValue)
        
        return RGB(red: randomRed, green: randomGreen, blue: randomBlue)
    }
    
    
    
    //가장큰값 maxValue보다 크면 maxValue로 가작 작은값 minValue보다 작으면 minValue를 주도록 했습니다.
    private func translateInputRGBValue(inputValue:Int) -> Int{
        
        if inputValue < RGB.minValue {
            return RGB.minValue
        } else if inputValue > RGB.maxValue {
            return RGB.maxValue
        } else {
            return inputValue
        }
        
    }
}

extension RGB:CustomStringConvertible {
        var description: String {
            return "#" + String(format:"%02X", red) + String(format:"%02X", green) + String(format:"%02X", blue)
    }
}

extension RGB:Equatable {
    static func == (lhs: RGB, rhs: RGB) -> Bool {
        lhs.hexValue == rhs.hexValue
    }
}
