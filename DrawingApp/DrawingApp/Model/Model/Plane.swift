//
//  Plane.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

class Plane {
    enum Event {
        static let didAddViewModel = Notification.Name("didAddViewModel")
        static let didSelectViewModel = Notification.Name("didSelectViewModel")
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
    
    private var viewModels: [ViewModel] = [] {
        didSet {
            guard let newModel = viewModels.last else { return }
            Log.info("Added: \(newModel)")
        }
    }
    
    var selected: ViewModel?
    
    var rectangleCount: Int {
        viewModels.filter { $0 is Rectangle }.count
    }
    
    var photoCount: Int {
        viewModels.filter { $0 is Photo }.count
    }
    
    var labelCount: Int {
        viewModels.filter { $0 is Label }.count
    }
    
    var viewModelCount: Int {
        viewModels.count
    }
    
    subscript(index: Int) -> ViewModel? {
        return (0..<viewModels.count).contains(index) ? viewModels[index] : nil
    }
    
    func add(viewModelType: ViewModelType, data: Data? = nil) {
        guard let newViewModel = ViewModelFactory.makeRandom(viewModelType, from: data) else { return }
        viewModels.append(newViewModel)
        NotificationCenter.default.post(name: Plane.Event.didAddViewModel, object: self, userInfo: [Plane.InfoKey.added: newViewModel])
    }
    
    func tap(on point: Point) {
        let unselected = selected
        self.selected = viewModels.last(where: { viewModel in
            viewModel.contains(point)
        })
        NotificationCenter.default.post(name: Plane.Event.didSelectViewModel, object: self, userInfo: [Plane.InfoKey.unselected: unselected as Any, Plane.InfoKey.selected: selected as Any])
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
        guard let viewModel = selected else { return }
        viewModel.set(to: toOrigin)
        NotificationCenter.default.post(name: Plane.Event.didChangeOrigin, object: self, userInfo: [Plane.InfoKey.changed: viewModel])
    }
    
    func changeSelected(toSize: Size) {
        guard let viewModel = selected else { return }
        viewModel.set(to: toSize)
        NotificationCenter.default.post(name: Plane.Event.didChangeSize, object: self, userInfo: [Plane.InfoKey.changed: viewModel])
    }
    
    func change(viewModel: ViewModel, toOrigin: Point) {
        viewModel.set(to: toOrigin)
        NotificationCenter.default.post(name: Plane.Event.didChangeOrigin, object: self, userInfo: [Plane.InfoKey.changed: viewModel])
    }
    
    func change(viewModel: ViewModel, toSize: Size) {
        viewModel.set(to: toSize)
        NotificationCenter.default.post(name: Plane.Event.didChangeSize, object: self, userInfo: [Plane.InfoKey.changed: viewModel])
    }
}
