//
//  Plane.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

protocol PlaneDelegate {
    func didAddViewModels(_ new: [ViewModel])
}

protocol PlaneSelectionDelegate {
    func didSelectViewModels(_ selected: ViewModel?)
}

class Plane {
    var viewModels: [ViewModel] = [] {
        didSet {
            guard let newModel = viewModels.last else { return }
            Log.info("Added: \(newModel)")
        }
    }
    
    var selected: ViewModel?
    var additionDelegate: PlaneDelegate?
    var selectionDelgate: PlaneSelectionDelegate?
    
    var rectangleCount: Int {
        viewModels.filter { $0 is Rectangle }.count
    }
    
    subscript(index: Int) -> ViewModel {
        return viewModels[index]
    }
    
    func addRectangle() {
        let newRectangle = Factory.createRectangle()
        viewModels.append(newRectangle)
        additionDelegate?.didAddViewModels([newRectangle])
    }
    
    func tap(on point: Point) {
        self.selected = viewModels.last(where: { viewModel in
            viewModel.contains(point)
        })
        selectionDelgate?.didSelectViewModels(selected)
    }
    
    func transform(to color: Color) {
        guard let mutableViewModel = selected as? ColorMutable else { return }
        mutableViewModel.transform(to: color)
    }
    
    func transform(to alpha: Alpha) {
        guard let mutableViewModel = selected as? AlphaMutable else { return }
        mutableViewModel.transform(to: alpha)
    }
}
