//
//  Convertor.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/11.
//

import Foundation
import UIKit


struct Convertor {
    
    
    static func convertColor(from color: Color) -> UIColor {
        let R = CGFloat(color.red) / 255
        let G = CGFloat(color.green) / 255
        let B = CGFloat(color.blue) / 255
        return UIColor(red: R, green: G, blue: B, alpha: 1)
    }
    
    static func convertColor(from color: UIColor) -> Color {
        return Color(R: Int(color.ciColor.red) * 255, G: Int(color.ciColor.green) * 255, B: Int(color.ciColor.blue) * 255)
    }
}
