//
//  CanvasViewModel.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/30.
//

import Foundation
import UIKit

class CanvasViewModel {
    let layerAddable: LayerAddable?
    let newView = Observable<UIView?>(nil)
    
    let layerSelectable: LayerSelectable?
    let selectedView = Observable<UIView?>(nil)
    let unselectedView = Observable<UIView?>(nil)
    
    var layerDict = [Layer: UIView]()
    
    init(layerAddable: LayerAddable?, layerSelectable: LayerSelectable?) {
        self.layerAddable = layerAddable
        self.layerSelectable = layerSelectable
    }
    
    func add<T: Layer>(of layerType: T.Type, imageData: Data? = nil) {
        layerAddable?.add(type: layerType, imageData: imageData) { [weak self] newLayer in
            let newView = ViewFactory.create(from: newLayer)
            self?.layerDict[newLayer] = newView
            self?.newView.value = newView
        }
    }
    
    func select(on point: Point) {
        layerSelectable?.select(on: point) { [weak self] unselected, selected in
            if let unselected = unselected {
                self?.unselectedView.value = self?.layerDict[unselected]
            }
            
            if let selected = selected {
                self?.selectedView.value = self?.layerDict[selected]
            }
        }
    }
}
