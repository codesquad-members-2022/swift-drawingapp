//
//  SelectService.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/30.
//

import Foundation

typealias onSelectHandler = ((Layer?, Layer?) -> Void)?

protocol LayerSelectable1 {
    func select(on point: Point, onSelect: onSelectHandler)
}

struct SelectService: LayerSelectable1 {
    
    var layerContainable: LayerContainable?
    
    init(layerContainable: LayerContainable?) {
        self.layerContainable = layerContainable
    }
    
    func select(on point: Point, onSelect: onSelectHandler) {
        let unselected = layerContainable?.selected
        let newSelected = layerContainable?.layers.last(where: { layer in
            layer.contains(point)
        })
        
        layerContainable?.selected = newSelected
        
        onSelect?(unselected, newSelected)
    }
}
