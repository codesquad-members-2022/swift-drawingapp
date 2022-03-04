//
//  CanvasViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/02/28.
//

import UIKit

class CanvasViewController: UIViewController {
    private var plane = Plane()
    private var viewIDMap = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observePlane()
        observePanel()
        
        setUpInitialModels()
        setUpRecognizer()
    }
}

// MARK: - Use case: Launch App

extension CanvasViewController {
    
    private func observePlane() {
        NotificationCenter.default.addObserver(self, selector: #selector(didAddViewModel(_:)), name: .addViewModel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectViewModel(_:)), name: .selectViewModel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateColor(_:)), name: .mutateColorViewModel, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didMutateAlpha(_:)), name: .mutateAlphaViewModel, object: nil)
    }
    
    private func observePanel() {
        NotificationCenter.default.addObserver(self, selector: #selector(sliderChanged(_:)), name: .sliderChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(colorButtonPressed(_:)), name: .colorButtonPressed, object: nil)
    }
    
    private func setUpRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    private func setUpInitialModels() {
        (0..<4).forEach { _ in plane.addRectangle() }
    }
}

// MARK: - Use Case: Add New Rectangle

extension CanvasViewController {
    
    @IBAction func addRectanglePressed(_ sender: UIButton) {
        plane.addRectangle()
    }
    
    @objc func didAddViewModel(_ notification: Notification) {
        guard let newViewModel = notification.object as? ViewModel else { return }
        guard let newBaseView = createBaseView(from: newViewModel) else { return }
        addViewID(newBaseView)
        view.addSubview(newBaseView)
    }
    
    private func createBaseView(from viewModel: ViewModel) -> BaseView? {
        return BaseView(viewModel: viewModel)
    }
    
    private func addViewID(_ new: BaseView) {
        viewIDMap[new.id] = new
    }
}

// MARK: - Use Case: Select Rectangle

extension CanvasViewController {
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: view)
        let tappedPoint = Point(x: location.x, y: location.y)
        plane.tap(on: tappedPoint)
    }
    
    
    @objc func didSelectViewModel(_ notification: Notification) {
        guard let (old, new) = notification.object as? (old: ViewModel?, new: ViewModel?) else { return }
        
        if let new = new {
            guard let newView = searchView(for: new) else { return }
            changeBorder(newView)
        }
        
        if let old = old {
            guard let oldView = searchView(for: old) else { return }
            clearBorder(oldView)
        }
    }
    
    private func searchView(for viewModel: ViewModel) -> UIView? {
        return viewIDMap[viewModel.id]
    }
    
    private func changeBorder(_ view: UIView) {
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    private func clearBorder(_ view: UIView) {
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.clear.cgColor
    }
    
}

// MARK: - Use Case: Transform Rectangle

extension CanvasViewController {
    
    @objc func colorButtonPressed(_ notification: Notification) {
        plane.transform()
    }
    
    @objc func didMutateColor(_ notification: Notification) {
        guard let mutated = notification.object as? ColorMutable else { return }
        let mutatedUIView = searchView(for: mutated as! ViewModel)
        mutatedUIView?.backgroundColor = Converter.toUIColor(mutated.color)
    }
    
    @objc func sliderChanged(_ notification: Notification) {
        guard let value = notification.object as? Float else { return }
        
        if let alpha = Alpha(value) {
            plane.transform(to: alpha)
        }
    }
    
    @objc func didMutateAlpha(_ notification: Notification) {
        guard let mutated = notification.object as? AlphaMutable else { return }
        let mutatedUIView = searchView(for: mutated as! ViewModel)
        mutatedUIView?.alpha = Converter.toCGFloat(mutated.alpha)
    }
}
