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
    
    let selectService = SelectService()
    let selectedView = Observable<UIView?>(nil)
    let unselectedView = Observable<UIView?>(nil)
    
    var layerDict = [Layer: UIView]()
    
    private func add<T: Layer>(of layerType: T.Type, imageData: Data? = nil) {
        addService.add(type: layerType, imageData: imageData) { [weak self] newLayer in
            let newView = ViewFactory.create(from: newLayer)
            self?.layerDict[newLayer] = newView
            self?.newView.value = newView
        }
    }
    
    func addRectangle() {
        self.add(of: Rectangle.self)
    }
    
    func addLabel() {
        self.add(of: Label.self)
    }
    
    func addPhoto(data: Data) {
        self.add(of: Photo.self, imageData: data)
    }
    
    func addPostIt() {
        self.add(of: PostIt.self)
    }
    
    func select(on point: Point) {
        selectService.select(on: point) { [weak self] unselected, selected in
            guard let unselected = unselected else { return }
            self?.unselectedView.value = self?.layerDict[unselected]
            
            guard let selected = selected else { return }
            self?.selectedView.value = self?.layerDict[selected]
        }
    }
}
