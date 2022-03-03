//
//  Size.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation
import UIKit

struct Size: CustomStringConvertible {
    let width: Double
    let height: Double
    
    var cgSize: CGSize {
        CGSize(width: width, height: height)
    }
    
    var description: String {
        "W\(width), H\(height)"
    }
}
