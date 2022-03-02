//
//  Plane.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation

protocol PlaneDelegate {
    func didUpdateViewModel(_ plane: Plane)
}

class Plane {
    private var viewModels: [viewModel] = [] {
        didSet {
            guard let newModel = viewModels.last else { return }
            Log.info("New viewModel is Added")
            Log.info("\(newModel)")
        }
    }
    var selected: viewModel?
    var delegate: Plane?
    
    var rectangleCount: Int {
        viewModels.filter { $0 is Rectangle }.count
    }
    
    func setUpInitialModels() {
        for _ in 0..<4 {
            addRectangle()
        }
    }
    
    func addRectangle() {
        viewModels.append(Factory.createRectangle())
    }
    
    subscript(index: Int) -> viewModel {
        return viewModels[index]
    }
    
    func tap(on point: Point) {
        let candidate = viewModels.filter { viewModel in
            viewModel.contains(point)
        }
        guard let selected = candidate.last else { return }
        self.selected = selected
    }
    
}
