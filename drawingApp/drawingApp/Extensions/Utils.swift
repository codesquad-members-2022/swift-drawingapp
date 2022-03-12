//
//  Utils.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import Foundation

extension Double {
    var trim : Double {
        Double(Int(ceil(self)))
    }
    
    var scaleRGB : Double {
        return self/255.0
    }

}

