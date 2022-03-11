//
//  MainScreenViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/06.
//

import UIKit

/// Plane에 전달된 Model 혹은 Model에 해당하는 프로퍼티들로 MainScreenViewController의 subviews를 변경합니다.
protocol MainScreenDelegate {
    /// Plane이 모델을 생성할 때 최대 X, Y 값을 참고하기 MainScreenViewController.view의 프로퍼티를 요청할 시 사용합니다.
    func getScreenViewProperty() -> FactoryProperties
}

final class MainScreenViewController: UIViewController, MainScreenDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    private var current: Rectangle?
    
    var delegate: MainScreenTapDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            forName: Plane.RectangleControlAction,
            object: nil,
            queue: OperationQueue.main
        ) { [weak self] noti in
            guard let self = self else { return }
            
            guard
                let model = noti.object as? RectangleProperty,
                let userInfo = noti.userInfo as? [Plane.PostKey: Any]
            else {
                return
            }
            
            guard
                let index = userInfo[.index] as? Int,
                let type = userInfo[.type] as? Plane.MainScreenAction
            else {
                return
            }
            
            switch type {
            case .AddButtonPushed:
                self.view.addSubview(Rectangle(model: model, index: index))
            case .ColorButtonPushed:
                self.current?.setBackgroundColor(using: model.rgbValue, alpha: model.alpha)
            case .SliderMoved:
                self.current?.setValue(alpha: Float(model.alpha))
            }
        }
    }
    
    // MARK: - MainScreenDelegate implementations
    func getScreenViewProperty() -> FactoryProperties {
        let frame = view.frame
        let defaultSize = (RectangleDefaultSize.width.rawValue, RectangleDefaultSize.height.rawValue)
        return FactoryProperties(
            maxX: (frame.width - defaultSize.0),
            maxY: (frame.height - defaultSize.1),
            width: defaultSize.0,
            height: defaultSize.1
        )
    }
    
    // MARK: - UIGestureRecognizerDelegate implementation
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchedView = touches.first?.view as? Rectangle
        current?.isSelected = false
        current = touchedView
        current?.isSelected = true
        
        // touchedView is nil when touched background
        delegate?.mainScreenView(didSelect: touchedView?.index)
    }
}
