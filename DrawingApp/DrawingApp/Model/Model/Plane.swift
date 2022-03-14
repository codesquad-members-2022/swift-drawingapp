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
    }
    
    enum InfoKey {
        static let added = "added"
        static let selected = "selected"
        static let unselected = "unselected"
        static let changed = "changed"
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
    
    subscript(index: Int) -> Layer? {
        return (0..<layers.count).contains(index) ? layers[index] : nil
    }
    
    func add(layerType: LayerType, data: Data? = nil) {
        guard let newLayer = LayerFactory.makeRandom(layerType, from: data) else { return }
        layers.append(newLayer)
        NotificationCenter.default.post(name: Plane.Event.didAddLayer, object: self, userInfo: [Plane.InfoKey.added: newLayer])
    }
    
    func tap(on point: Point) {
        let unselected = selected
        self.selected = layers.last(where: { layer in
            layer.contains(point)
        })
        NotificationCenter.default.post(name: Plane.Event.didSelectLayer, object: self, userInfo: [Plane.InfoKey.unselected: unselected as Any, Plane.InfoKey.selected: selected as Any])
    }
    
    func changeSelected(toColor: Color = Color.random()) {
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
