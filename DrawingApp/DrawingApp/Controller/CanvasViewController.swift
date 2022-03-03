//
//  CanvasViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit

class CanvasViewController: UIViewController {
    private var containerVC: DrawingSplitViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        containerVC = splitViewController as? DrawingSplitViewController
        containerVC?.plane.canvasDelegate = self
        setUpInitialModels()
        setUpRecognizer()
    }
    
    private func setUpRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    private func setUpInitialModels() {
        (0..<4).forEach { _ in containerVC?.plane.addRectangle() }
    }
    
    @IBAction func addRectanglePressed(_ sender: UIButton) {
        containerVC?.plane.addRectangle()
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        containerVC?.plane.tap(on: Point(cgPoint: location))
    }
    
    private func getMatchedUIView(with viewModel: ViewModel) -> UIView? {
        return view.subviews.first(where: {
            guard let baseView = $0 as? BaseView else { return false }
            return baseView.id == viewModel.id
        })
    }
    
    private func changeBorder(_ view: UIView) {
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func clearBorder(_ view: UIView) {
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.clear.cgColor
    }

    private func createBaseView(from viewModel: ViewModel) -> BaseView? {
        return BaseView(viewModel: viewModel)
    }
}

extension CanvasViewController: PlaneCanvasDelegate {
    func didSelectViewModels(_ new: ViewModel?, _ old: ViewModel?) {
        if let new = new {
            guard let newView = getMatchedUIView(with: new) else { return }
            changeBorder(newView)
        }
        
        if let old = old {
            guard let oldView = getMatchedUIView(with: old) else { return }
            clearBorder(oldView)
        }
    }
    
    
    func didAddViewModels(_ new: [ViewModel]) {
        for newViewModel in new {
            guard let newUIView = createBaseView(from: newViewModel) else { continue }
            view.addSubview(newUIView)
        }
    }
    
    func didMutateColorViewModels(_ mutated: ColorMutable) {
        let mutatedUIView = getMatchedUIView(with: mutated as! ViewModel)
        mutatedUIView?.backgroundColor = mutated.color.uiColor
    }
    
    func didMutateAlphaViewModels(_ mutated: AlphaMutable) {
        let mutatedUIView = getMatchedUIView(with: mutated as! ViewModel)
        mutatedUIView?.alpha = mutated.cgAlpha
    }
}
