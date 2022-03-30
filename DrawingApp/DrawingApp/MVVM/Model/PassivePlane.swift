//
//  PassivePlane.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/30.
//

import Foundation

class PassivePlane {
    
    // Use singleton for different services to access
    static let shared = PassivePlane()
    
    var layers: [Layer]
    var selected: Layer?
    
    init(layers: [Layer] = [], selected: Layer? = nil) {
        self.layers = layers
        self.selected = selected
    }
    
}
