//
//  Alpha.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/02.
//

import Foundation

struct Alpha {
    let value: Double
    
    init(opacityLevel: Int) {
        let maxOpacityLavel = 10
        let minOpacityLevel = 1
        
        if opacityLevel > maxOpacityLavel {
            self.value = 1.0
        } else if opacityLevel < minOpacityLevel {
            self.value = 0
        } else {
            let possibileAlphaValue = [0, 0.1, 0.2, 0.3, 0.4, 0.5,
                                      0.6, 0.7, 0.8, 0.9, 1.0]
            self.value = possibileAlphaValue[opacityLevel]
        }

    }
}
