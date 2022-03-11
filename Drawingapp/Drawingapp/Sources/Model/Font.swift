//
//  Font.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation
import UIKit

struct Font: CustomStringConvertible {
    let name: String
    let size: Double
    
    var description: String {
        "font: { name: \(name), size: \(size)"
    }
    
    var uiFont: UIFont? {
        UIFont(name: name, size: size)
    }
}

extension Font {
    static var names = ["AppleSDGothicNeo-Bold","AppleSDGothicNeo-Light",
                 "AppleSDGothicNeo-Medium", "AppleSDGothicNeo-Regular",
                 "AppleSDGothicNeo-SemiBold", "AppleSDGothicNeo-Thin",
                 "AppleSDGothicNeo-UltraLight"]
}
