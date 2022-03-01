//
//  Alpha.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import Foundation

class Alpha {
    
    private let alpha: Opacity
    
    enum Opacity: Int {
        case one = 1, two, three, four, five, six, seven, eight, nine, ten
    }
    
    init(alpha: Opacity) {
        self.alpha = alpha
    }
    
}
