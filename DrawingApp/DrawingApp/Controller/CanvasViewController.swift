//
//  CanvasViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit

class CanvasViewController: UIViewController {
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
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let selectedView = gesture.view else { return }
        changeBorder(selectedView)
        
        if let oldSelected = plane.selected, let oldSelectedUIView = getMatchedUIView(with: oldSelected) {
            clearBorder(oldSelectedUIView)
        }
        
        let location = gesture.location(in: view)
        plane.tap(on: Point(cgPoint: location))
    }
    
    func getMatchedUIView(with viewModel: ViewModel) -> UIView? {
        return view.subviews.first(where: {
            guard let baseView = $0 as? BaseView else { return false }
            return baseView.id == viewModel.id
        })
    }
    
    func changeBorder(_ view: UIView) {
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func clearBorder(_ view: UIView) {
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.clear.cgColor
    }

    func createBaseView(from viewModel: ViewModel) -> BaseView? {
        return BaseView(viewModel: viewModel)
    }
}

extension CanvasViewController: PlaneDelegate {
    func didAddViewModels(_ new: [ViewModel]) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        for newViewModel in new {
            guard let newUIView = createBaseView(from: newViewModel) else { continue }
            view.addSubview(newUIView)
            newUIView.addGestureRecognizer(tap)
        }
    }
    
    func didSelectViewModels(_ selected: ViewModel) {
        
    }
    
}
