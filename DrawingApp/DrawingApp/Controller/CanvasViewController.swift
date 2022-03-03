//
//  CanvasViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit

class CanvasViewController: UIViewController, PlaneDelegate {
    private let plane = Plane()

    override func viewDidLoad() {
        super.viewDidLoad()
        plane.delegate = self
        setUpInitialModels()
    }
    
    func setUpInitialModels() {
        (0..<4).forEach { _ in plane.addRectangle() }
    }
    
    @IBAction func addRectanglePressed(_ sender: UIButton) {
        plane.addRectangle()
    }

    func didAddViewModels(_ newViewModels: [ViewModel]) {
        for newViewModel in newViewModels {
            guard let newUIView = createUIView(from: newViewModel) else { continue }
            view.addSubview(newUIView)
        }
    }
    
    func createUIView(from viewModel: ViewModel) -> UIView? {
        if let rectangle = viewModel as? Rectangle { return RectangleView(viewModel: rectangle) }
        return nil
    }
}

