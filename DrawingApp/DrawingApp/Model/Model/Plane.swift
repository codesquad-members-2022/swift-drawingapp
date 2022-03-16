//
//  Plane.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

class Plane {
    enum Event {
        static let didAddLayer = Notification.Name("didAddLayer")
        static let didSelectLayer = Notification.Name("didSelectLayer")
        static let didChangeColor = Notification.Name("didChangeColor")
        static let didChangeAlpha = Notification.Name("didChangeAlpha")
        static let didChangeOrigin = Notification.Name("didChangeOrigin")
        static let didChangeSize = Notification.Name("didChangeSize")
        static let didChangeText = Notification.Name("didChangeText")
        static let didReorderLayer = Notification.Name("didReorderLayer")
    }
    
    enum InfoKey {
        static let added = "added"
        static let selected = "selected"
        static let unselected = "unselected"
        static let changed = "changed"
        static let fromIndex = "from"
        static let toIndex = "to"
        static let reorderCommand = "reorderCommand"
    }
    
    enum reorderCommand: CaseIterable {
        case sendToBack
        case bringToFront
        case sendBackward
        case bringForward
    }
    
    private var layers: [Layer] = [] {
        didSet {
            guard let newModel = layers.last else { return }
            Log.info("Added: \(newModel)")
        }
    }
    
    var selected: Layer?
    
    var rectangleCount: Int {
        layers.filter { $0 is Rectangle }.count
    }
    
    var photoCount: Int {
        layers.filter { $0 is Photo }.count
    }
    
    var labelCount: Int {
        layers.filter { $0 is Label }.count
    }
    
    var layerCount: Int {
        layers.count
    }
    
    func layerCount(of layerType: LayerType) -> Int {
        switch layerType {
        case .rectangle:
            return rectangleCount
        case .photo:
            return photoCount
        case .label:
            return labelCount
        }
    }
    
    subscript(index: Int) -> Layer? {
        return (0..<layers.count).contains(index) ? layers[index] : nil
    }
    
    func add(layerType: LayerType, data: Data? = nil) {
        guard let newLayer = LayerFactory.makeRandom(layerType, titleOrder: layerCount(of: layerType)+1, from: data) else { return }
        layers.append(newLayer)
        NotificationCenter.default.post(name: Plane.Event.didAddLayer, object: self, userInfo: [Plane.InfoKey.added: newLayer])
    }
    
    func select(layer: Layer?) {
        let unselected = selected
        self.selected = selected == layer ? nil : layer
        
        NotificationCenter.default.post(name: Plane.Event.didSelectLayer, object: self, userInfo: [Plane.InfoKey.unselected: unselected as Any, Plane.InfoKey.selected: selected as Any])
    }
    
    func reorderLayer(_ layer: Layer, to command: Plane.reorderCommand) {
        var fromIndex = 0, toIndex = 0
        
        switch command {
        case .bringForward:
            guard let current = layers.firstIndex(of: layer) else { return }
            fromIndex = current
            toIndex = current + 1
            
        case .sendBackward:
            guard let current = layers.firstIndex(of: layer) else { return }
            fromIndex = current
            toIndex = current - 1
            
        case .bringToFront:
            guard let current = layers.firstIndex(of: layer) else { return }
            fromIndex = current
            toIndex = layers.count-1
            
        case .sendToBack:
            guard let current = layers.firstIndex(of: layer) else { return }
            fromIndex = current
            toIndex = 0
        }
        
        reorderLayer(fromIndex: fromIndex, toIndex: toIndex)
    }
    
    func reorderLayer(fromIndex: Int, toIndex: Int) {
        guard 0 <= toIndex, toIndex < layerCount,
                0 <= fromIndex, fromIndex < layerCount else { return }
        
        let layerToMove = layers.remove(at: fromIndex)
        layers.insert(layerToMove, at: toIndex)
        
        NotificationCenter.default.post(name: Plane.Event.didReorderLayer, object: self, userInfo: [Plane.InfoKey.changed: layerToMove, Plane.InfoKey.fromIndex: fromIndex, Plane.InfoKey.toIndex: toIndex])
    }
    
    func tap(on point: Point) {
        let unselected = selected
        self.selected = layers.last(where: { layer in
            layer.contains(point)
        })
        NotificationCenter.default.post(name: Plane.Event.didSelectLayer, object: self, userInfo: [Plane.InfoKey.unselected: unselected as Any, Plane.InfoKey.selected: selected as Any])
    }
    
    func changeSelected(toColor: Color) {
        guard let colorMutable = selected as? ColorMutable else { return }
        colorMutable.set(to: toColor)
        NotificationCenter.default.post(name: Plane.Event.didChangeColor, object: self, userInfo: [Plane.InfoKey.changed: toColor])
    }
    
    func changeSelected(toAlpha: Alpha) {
        guard let alphaMutable = selected as? AlphaMutable else { return }
        alphaMutable.set(to: toAlpha)
        NotificationCenter.default.post(name: Plane.Event.didChangeAlpha, object: self, userInfo: [Plane.InfoKey.changed: toAlpha])
    }
    
    func changeSelected(toText: String) {
        guard let textMutable = selected as? TextMutable else { return }
        textMutable.set(to: toText)
        NotificationCenter.default.post(name: Plane.Event.didChangeText, object: self, userInfo: [Plane.InfoKey.changed: toText])
    }
    
    func changeSelected(toOrigin: Point) {
        guard let layer = selected else { return }
        layer.set(to: toOrigin)
        NotificationCenter.default.post(name: Plane.Event.didChangeOrigin, object: self, userInfo: [Plane.InfoKey.changed: layer])
    }
    
    func changeSelected(toSize: Size) {
        guard let layer = selected else { return }
        layer.set(to: toSize)
        NotificationCenter.default.post(name: Plane.Event.didChangeSize, object: self, userInfo: [Plane.InfoKey.changed: layer])
    }
    
    func change(layer: Layer, toOrigin: Point) {
        layer.set(to: toOrigin)
        NotificationCenter.default.post(name: Plane.Event.didChangeOrigin, object: self, userInfo: [Plane.InfoKey.changed: layer])
    }
    
    func change(layer: Layer, toSize: Size) {
        layer.set(to: toSize)
        NotificationCenter.default.post(name: Plane.Event.didChangeSize, object: self, userInfo: [Plane.InfoKey.changed: layer])
    }
}
