//
//  MainScreenViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/06.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    private var rectangleViews = [Rectangle]()
    private var selectedIndexes: Set<Int>?
    
    var rectangleDelegate: MainSceneTapDelegate?
    
    private let factoryRectangle = FactoryMainScreenRectangle()
    
    private let selectGesture = UITapGestureRecognizer()
    private let doubleTouchesCopyGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            forName: Plane.addViewButtonPushed,
            object: rectangleDelegate,
            queue: .current
        ) { [weak self] noti in
            guard
                let self = self,
                let userInfo = noti.userInfo as? [Plane.PostKey: Any]
            else {
                return
            }
            
            OperationQueue.main.addOperation {
                self.addRectangleObserve(userInfo)
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: Plane.sliderMoved,
            object: rectangleDelegate,
            queue: .current
        ) { [weak self] noti in
            guard
                let self = self,
                let userInfo = noti.userInfo as? [Plane.PostKey: Any]
            else {
                return
            }
            
            OperationQueue.main.addOperation {
                self.setValueObserve(userInfo)
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: Plane.colorButtonPushed,
            object: rectangleDelegate,
            queue: .current
        ) { [weak self] noti in
            guard
                let self = self,
                let userInfo = noti.userInfo as? [Plane.PostKey: Any]
            else {
                return
            }
            
            OperationQueue.main.addOperation {
                self.setColorObserve(userInfo)
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: Plane.selectStatusChanged,
            object: rectangleDelegate,
            queue: .current)
        { [weak self] noti in
            guard
                let self = self,
                let userInfo = noti.userInfo as? [Plane.PostKey: Any]
            else {
                return
            }
            
            OperationQueue.main.addOperation {
                self.setRectangleStatusChange(userInfo)
            }
        }
        
        selectGesture.delegate = self
        doubleTouchesCopyGesture.delegate = self
        doubleTouchesCopyGesture.numberOfTouchesRequired = 2
        view.addGestureRecognizer(selectGesture)
        view.addGestureRecognizer(doubleTouchesCopyGesture)
    }
    
    // MARK: - Methods Process ObserverTask
    private func addRectangleObserve(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let model = userInfo[.model] as? RectangleProperty,
            let index = userInfo[.index] as? Int
        else {
            return
        }
        
        guard let rect = factoryRectangle.makeRectangle(from: model, at: index) else { return }
        
        rect.addGestureRecognizer(selectGesture)
        rectangleViews.append(rect)
        view.addSubview(rect)
    }
    
    private func setValueObserve(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let model = userInfo[.model] as? RectangleProperty,
            let index = userInfo[.index] as? Int
        else {
            return
        }
        
        let rect = rectangleViews.first(where: {$0.index == index}) as? EnableSetAlphaRectangle
        rect?.setValue(alpha: model.alpha)
    }
    
    private func setColorObserve(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let model = userInfo[.model] as? ColoredRectangleProperty,
            let index = userInfo[.index] as? Int
        else {
            return
        }
        
        let rect = rectangleViews.first(where: {$0.index == index}) as? ColoredRectangle
        rect?.setBackgroundColor(using: model.rgbValue, alpha: model.alpha)
    }
    
    private func setRectangleStatusChange(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let selectedIndex = userInfo[.index] as? Int
        else {
            return
        }
        
        for rect in rectangleViews {
            rect.isSelected = (rect.index == selectedIndex)
        }
    }
    
    @objc func drag(_ sender: UIPanGestureRecognizer) {
        guard let rect = sender.view as? Rectangle else { return }
        if sender.state == .ended, let copiedView = rect.copiedView {
            let origin = RectOrigin(x: rect.frame.minX, y: rect.frame.minY)
            
            UIView.animate(withDuration: 0.5) {
                copiedView.frame.origin = rect.frame.origin
                rect.removeFromSuperview()
                self.rectangleViews[rect.index] = copiedView
                
                rect.gestureRecognizers?.forEach({ recognizer in
                    rect.removeGestureRecognizer(recognizer)
                })
            }
            
            DispatchQueue.global(qos: .utility).async {
                self.rectangleDelegate?.didMoved(rect: origin, at: rect.index)
            }
            
            return
        }
        
        
        let translation = sender.translation(in: self.view)
        rect.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(.zero, in: self.view)
    }
}

// MARK: - UIGestureRecognizerDelegate implementations.

extension MainScreenViewController: UIGestureRecognizerDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let rect = touches.first?.view as? Rectangle else {
            rectangleDelegate?.didSelect(at: nil)
            return
        }
        
        if touches.count == 1 {
            
            rectangleDelegate?.didSelect(at: rect.index)
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
            rect.addGestureRecognizer(panGesture)
            panGesture.minimumNumberOfTouches = 2
            panGesture.delegate = self
            rect.addGestureRecognizer(panGesture)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard
            gestureRecognizer is UITapGestureRecognizer,
            let rect = touch.view as? Rectangle, rect.isSelected, rect.copiedView == nil,
            let model = rectangleDelegate?.getRectangleModel(at: rect.index),
            let copiedView = factoryRectangle.makeRectangle(from: model, at: rect.index)
        else {
            return true
        }

        view.insertSubview(copiedView, belowSubview: rect)
        
        rect.setCopiedView(rect: copiedView)
        rectangleDelegate?.didSelect(at: nil)
        rect.coverOpaqueView()

        return true
    }
}
