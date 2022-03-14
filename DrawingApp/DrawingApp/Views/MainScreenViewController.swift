//
//  MainScreenViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/06.
//

import UIKit

/// Plane에 전달된 Model 혹은 Model에 해당하는 프로퍼티들로 MainScreenViewController의 subviews를 변경합니다.
protocol MainSceneDelegate {
    /// Plane이 모델을 생성할 때 최대 X, Y 값을 참고하기 MainScreenViewController.view의 프로퍼티를 요청할 시 사용합니다.
    func getRect() -> RectangleRect
}

final class MainScreenViewController: UIViewController, MainSceneDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    private var rectangleViews = [Rectangle]()
    private var selectedIndexes: Set<Int>?
    
    var delegate: MainSceneTapDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            forName: Plane.addButtonPushed,
            object: delegate,
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
            object: delegate,
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
            object: delegate,
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
            object: delegate,
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
        
        let rect = Rectangle(model: model, index: index)
        self.rectangleViews.append(rect)
        view.addSubview(rect)
    }
    
    private func setValueObserve(_ userInfo: [Plane.PostKey: Any]) {
        guard
            let model = userInfo[.model] as? RectangleProperty,
            let index = userInfo[.index] as? Int
        else { return }
        
        rectangleViews.first(where: {$0.index == index})?
            .setValue(alpha: Float(model.alpha))
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
    
    // MARK: - MainScreenDelegate implementations
    func getRect() -> RectangleRect {
        let frame = view.frame
        let defaultSize = (RectangleDefaultSize.width.rawValue, RectangleDefaultSize.height.rawValue)
        return RectangleRect(
            maxX: (frame.width - defaultSize.0),
            maxY: (frame.height - defaultSize.1),
            width: defaultSize.0,
            height: defaultSize.1
        )
    }
    
    // MARK: - UIGestureRecognizerDelegate implementation
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchedView = touches.first?.view as? Rectangle
        delegate?.mainSceneDidSelect(at: touchedView?.index)
    }
}
