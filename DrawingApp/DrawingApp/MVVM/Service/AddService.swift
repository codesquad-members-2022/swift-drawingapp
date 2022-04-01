//
//  AddService.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/30.
//

import Foundation

typealias onAddHandler = ((Layer) -> Void)?

protocol LayerAddable {
    func add<T: Layer>(type: T.Type, imageData: Data?, onAdd: onAddHandler)
}

struct AddService: LayerAddable {
    
    var layerContainable: LayerContainable?
    
    init(layerContainable: LayerContainable?) {
        self.layerContainable = layerContainable
    }
    
    func add<T: Layer>(type: T.Type, imageData: Data? = nil, onAdd: onAddHandler) {
        guard let newLayer = LayerFactory.makeRandom(type, titleOrder: layerCount(of: type) + 1, from: imageData) else { return }
        
        layerContainable?.layers.append(newLayer)
        
        onAdd?(newLayer)
    }
    
    private func layerCount<T: Layer>(of type: T.Type) -> Int {
        return layerContainable?.layers.filter { $0 is T }.count ?? 0
    }
}
