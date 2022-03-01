//
//  ColorExtension.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

extension Color {
    var uiColor: UIColor {
        UIColor(red: CGFloat(r / 255), green: CGFloat(g / 255), blue: CGFloat(b / 255), alpha: 1)
    }
}

extension Color {
    static var black = Color(r: 0, g: 0, b: 0)
}
