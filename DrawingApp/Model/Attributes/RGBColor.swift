//
//  RGBColor.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/03/02.
//

import Foundation
import UIKit

struct RGBColor{
    let red: Double
    let green: Double
    let blue: Double
    
    func redValue() -> Double{
        return self.red / 255
    }
    
    func greenValue() -> Double{
        return self.green / 255
    }
    
    func blueValue() -> Double{
        return self.blue / 255
    }
    
    init(red: Double, green: Double, blue: Double){
        if red < 0 || red > 255{
            self.red = 255
        } else{
            self.red = red
        }
        
        if green < 0 || green > 255{
            self.green = 255
        } else{
            self.green = green
        }
        
        if blue < 0 || blue > 255{
            self.blue = 255
        } else{
            self.blue = blue
        }
    }
}
