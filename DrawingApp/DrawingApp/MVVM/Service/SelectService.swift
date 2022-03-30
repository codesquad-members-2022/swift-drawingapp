//
//  SelectService.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/30.
//

import Foundation

struct SelectService {
    
    let plane = PassivePlane.shared
    
    typealias onSelectHandler = ((Layer?, Layer?) -> Void)?
    
    func select(on point: Point, onSelect: onSelectHandler) {
        let unselected = plane.selected
        let newSelected = plane.layers.last(where: { layer in
            layer.contains(point)
        })
        
        plane.selected = newSelected
        
        onSelect?(unselected, newSelected)
    }
}
