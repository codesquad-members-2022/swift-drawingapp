//
//  Plane.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

protocol PlaneCanvasDelegate {
    func didAddViewModels(_ new: [ViewModel])
    func didSelectViewModels(_ new: ViewModel?, _ old: ViewModel?)
    func didMutateColorViewModels(_ mutated: ColorMutable)
    func didMutateAlphaViewModels(_ mutated: AlphaMutable)
}

protocol PlanePanelDelegate {
    func didSelectViewModels(_ selected: ViewModel?)
    func didMutateColorViewModels(_ mutated: ColorMutable)
    func didMutateAlphaViewModels(_ mutated: AlphaMutable)
}

class Plane {
    var viewModels: [ViewModel] = [] {
        didSet {
            guard let newModel = viewModels.last else { return }
            Log.info("Added: \(newModel)")
        }
    }
    
    var selected: ViewModel?
    var canvasDelegate: PlaneCanvasDelegate?
    var panelDelgate: PlanePanelDelegate?
    
    
    var rectangleCount: Int {
        viewModels.filter { $0 is Rectangle }.count
    }
    
    subscript(index: Int) -> ViewModel {
        return viewModels[index]
    }
    
    func addRectangle() {
        let newRectangle = Factory.createRectangle()
        viewModels.append(newRectangle)
        canvasDelegate?.didAddViewModels([newRectangle])
    }
    
    func tap(on point: Point) {
        let oldSelected = selected
        self.selected = viewModels.last(where: { viewModel in
            viewModel.contains(point)
        })
        panelDelgate?.didSelectViewModels(selected)
        canvasDelegate?.didSelectViewModels(selected, oldSelected)
    }
    
    func transform(to color: Color) {
        guard let mutableViewModel = selected as? ColorMutable else { return }
        mutableViewModel.transform(to: color)
        canvasDelegate?.didMutateColorViewModels(mutableViewModel)
        panelDelgate?.didMutateColorViewModels(mutableViewModel)
    }
    
    func transform(to alpha: Alpha) {
        guard let mutableViewModel = selected as? AlphaMutable else { return }
        mutableViewModel.transform(to: alpha)
        canvasDelegate?.didMutateAlphaViewModels(mutableViewModel)
        panelDelgate?.didMutateAlphaViewModels(mutableViewModel)
    }
}
