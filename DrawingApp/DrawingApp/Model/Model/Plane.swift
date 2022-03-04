//
//  Plane.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

extension Notification.Name {
    static let addViewModel = Notification.Name("addViewModel")
    static let selectViewModel = Notification.Name("selectViewModel")
    static let mutateColorViewModel = Notification.Name("mutateColorViewModel")
    static let mutateAlphaViewModel = Notification.Name("mutateAlphaViewModel")
}

class Plane {
    var viewModels: [ViewModel] = [] {
        didSet {
            guard let newModel = viewModels.last else { return }
            Log.info("Added: \(newModel)")
        }
    }
    
    var selected: ViewModel?
    
    var rectangleCount: Int {
        viewModels.filter { $0 is Rectangle }.count
    }
    
    subscript(index: Int) -> ViewModel {
        return viewModels[index]
    }
    
    func addRectangle() {
        let newRectangle = Factory.createRectangle()
        viewModels.append(newRectangle)
        NotificationCenter.default.post(name: .addViewModel, object: newRectangle)
    }
    
    func tap(on point: Point) {
        let oldSelected = selected
        self.selected = viewModels.last(where: { viewModel in
            viewModel.contains(point)
        })
        NotificationCenter.default.post(name: .selectViewModel, object: (old: oldSelected, new: selected))
    }
    
    func transform(to color: Color = Factory.createColor()) {
        guard let mutableViewModel = selected as? ColorMutable else { return }
        mutableViewModel.transform(to: color)
        NotificationCenter.default.post(name: .mutateColorViewModel, object: mutableViewModel)
    }
    
    func transform(to alpha: Alpha) {
        guard let mutableViewModel = selected as? AlphaMutable else { return }
        mutableViewModel.transform(to: alpha)
        NotificationCenter.default.post(name: .mutateAlphaViewModel, object: mutableViewModel)
    }
}
