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
        
        doubleTouchesCopyGesture.delegate = self
        doubleTouchesCopyGesture.numberOfTouchesRequired = 2
        view.addGestureRecognizer(selectGesture)
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
        
        // panGesture가 끝났기 때문에 copiedView를 rectangle이 있던 자리를 차지하도록 하고, 기존 이동하던 rectangle은 지웁니다.
        if sender.state == .ended, let copiedView = rect.copiedView {
            copiedView.addGestureRecognizer(selectGesture)
            
            let origin = RectOrigin(x: rect.frame.minX, y: rect.frame.minY)
            let index = rect.index
            
            UIView.animate(withDuration: 0.5) {
                copiedView.frame.origin = rect.frame.origin
                rect.removeFromSuperview()
                self.rectangleViews[index] = copiedView
            }
            
            rectangleDelegate?.didMoved(rect: origin, at: index)
            
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
        
        // 처음 rectangle을 선택하면 두 손가락으로 선택하는 제스쳐, 팬 제스쳐를 추가하여 임시 뷰 생성 및 이동이 가능하도록 합니다.
        if touches.count == 1 {
            rectangleDelegate?.didSelect(at: rect.index)
            rect.addGestureRecognizer(doubleTouchesCopyGesture)
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
            rect.addGestureRecognizer(panGesture)
            panGesture.minimumNumberOfTouches = 2
            panGesture.delegate = self
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard
            gestureRecognizer == doubleTouchesCopyGesture,
            let rect = touch.view as? Rectangle, rect.isSelected, rect.copiedView == nil,
            let model = rectangleDelegate?.getRectangleModel(at: rect.index),
            let copiedView = factoryRectangle.makeRectangle(from: model, at: rect.index)
        else {
            return true
        }
        
        // 두 손가락으로 선택하는 제스쳐로 뷰를 복사하고 선택 효과는 낼 수 없게 만듭니다. 선택 효과를 내는 제스쳐와 두 손가락 제스쳐가 겹쳐서 오류가 발생하였습니다.
        view.insertSubview(copiedView, belowSubview: rect)

        rect.setCopiedView(rect: copiedView)
        rect.removeGestureRecognizer(selectGesture)
        rect.setAlpha(model.alpha/20)
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let rect = touches.first?.view as? Rectangle, let copiedView = rect.copiedView else { return }
        
        // 만약 임시 뷰가 있음에도 이동이 없었던 경우라면 rectangle이 임시뷰 역할을 하지 않도록 하고, 복사된 뷰는 제거합니다.
        if rect.frame.origin == copiedView.frame.origin {
            copiedView.removeFromSuperview()
            rect.setAlpha((rectangleDelegate?.getRectangleModel(at: rect.index)?.alpha ?? 1)/10)
            rect.setCopiedView(rect: nil)
        }
    }
}
