//
//  Utils.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import Foundation
import UIKit

extension Double {
    var trim : Double {
        let str = String(format: "%.f", self)
        return Double(str)!
    }
    
    var scaleRGB : Double {
        return self/255.0
    }
    
    var scaleAlhpa : Double {
        return self/10.0
    }
}

extension CGFloat {
    var trim : Double {
        let str = String(format: "%.0f", self)
        return Double(str)!
    }
}

extension Color {
    
    var tohexString : String {
        let rgb:Int = (Int)(self.red)<<16 | (Int)(self.green)<<8 | (Int)(self.blue)<<0
        return String(format:"#%06x", rgb)
    }
    
   static func getRandomColor() -> Color {
        let red = Double.random(in: 0..<255)
        let green = Double.random(in: 0..<255)
        let blue = Double.random(in: 0..<255)
        return Color(r: red, g: green, b: blue)
    }
    
    
}
