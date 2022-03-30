//
//  CanvasViewModel.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/30.
//

import Foundation
import UIKit

class CanvasViewModel {
    let addService = AddService()
    let newView = Observable<UIView?>(nil)
    
    var layerDict = [Layer: UIView]()
    
    func add<T: Layer>(of layerType: T.Type, imageData: Data? = nil) {
        addService.add(type: layerType, imageData: imageData) { [weak self] newLayer in
            let newView = ViewFactory.create(from: newLayer)
            self?.layerDict[newLayer] = newView
            self?.newView.value = newView
        }
    }
}
