//
//  MainScreenViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/06.
//

import UIKit

final class MainScreenViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    private var rectangleViews = [Rectangle]()
    private var selectedIndexes: Set<Int>?
    
    var rectangleDelegate: MainSceneTapDelegate?
    
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
                self.setBackgroundColorObserve(userInfo)
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
    }
    
    // MARK: - Methods Process ObserverTask
    private func addRectangleObserve(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let model = userInfo[.model] as? RectangleProperty,
            let index = userInfo[.index] as? Int
        else {
            return
        }
        
        let rect = Rectangle(model: model, index: index, backgroundImage: (userInfo[.viewProperty] as? UIImage))
        self.rectangleViews.append(rect)
        view.addSubview(rect)
    }
    
    private func setValueObserve(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let model = userInfo[.model] as? RectangleProperty,
            let index = userInfo[.index] as? Int
        else { return }
        
        rectangleViews.first(where: {$0.index == index})?
            .setValue(alpha: model.alpha)
    }
    
    private func setBackgroundColorObserve(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let model = userInfo[.model] as? RectangleProperty,
            let index = userInfo[.index] as? Int
        else {
            return
        }
        
        rectangleViews.first(where: {$0.index == index})?
            .setBackgroundColor(using: model.rgbValue, alpha: model.alpha)
    }
    
    private func setRectangleStatusChange(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let selectedIndex = userInfo[.index] as? Int
        else {
            return
        }
        
        for rect in self.rectangleViews {
            rect.isSelected = (rect.index == selectedIndex)
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate implementation
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchedView = touches.first?.view as? Rectangle
        rectangleDelegate?.didSelect(at: touchedView?.index)
    }
}
