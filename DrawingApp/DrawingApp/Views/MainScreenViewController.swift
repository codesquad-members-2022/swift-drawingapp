//
//  MainScreenViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/06.
//

import UIKit

/// Plane에 전달된 Model 혹은 Model에 해당하는 프로퍼티들로 MainScreenViewController의 subviews를 변경합니다.
protocol MainScreenDelegate {
    /// Plane이 만든 랜덤으로 생성된 Model을 반영한 Rectangle 객체를 MainScreenViewController의 뷰에 추가합니다.
    ///
    /// 생성된 Rectangle은 MainScreenViewController가 확장한 UIGestureRecognizerDelegate의 영향을 받습니다.
    func addRectangle(using property: RectangleProperty, index: Int)
    /// Plane으로부터 전달된 RectRGBColor와 Alpha 값을 이용하여 자신의 뷰 중 하나에 색상을 반영합니다.
    func admitColor(to view: Rectangle, using color: RectRGBColor, alpha: Double)
    /// Plane으로부터 전달된 Alpha 값을 이용하여 자신의 뷰 중 하나에 Alpha값을 변경합니다.
    func admitAlpha(to view: Rectangle, using value: Float)
    /// Plane이 모델을 생성할 때 최대 X, Y 값을 참고하기 MainScreenViewController.view의 프로퍼티를 요청할 시 사용합니다.
    func getScreenViewProperty() -> FactoryProperties
}

final class MainScreenViewController: UIViewController, MainScreenDelegate, UIGestureRecognizerDelegate {
    
    var delegate: RectangleViewTapDelegate?
    private var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapHandler(_:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
    }
    
    // MARK: - MainScreenDelegate implementations
    func addRectangle(using property: RectangleProperty, index: Int) {
        let rect = Rectangle(model: property, index: index)
        let rectTapGesture = UITapGestureRecognizer(target: rect, action: #selector(rect.rectTapHandler(_:)))
        rect.addGestureRecognizer(rectTapGesture)
        rectTapGesture.delegate = self
        view.addSubview(rect)
    }
    
    func admitColor(to rect: Rectangle, using color: RectRGBColor, alpha: Double) {
        guard view.subviews.contains(where: {($0 as? Rectangle) == rect}) else { return }
        rect.setBackgroundColor(using: color, alpha: alpha)
    }
    
    func admitAlpha(to rect: Rectangle, using value: Float) {
        guard view.subviews.contains(where: {($0 as? Rectangle) == rect}) else { return }
        rect.setValue(alpha: value)
    }
    
    func getScreenViewProperty() -> FactoryProperties {
        let frame = view.frame
        let defaultSize = (FactoryRectangleDefaultSize.width.rawValue, FactoryRectangleDefaultSize.height.rawValue)
        return FactoryProperties(
            maxX: (frame.width - defaultSize.0),
            maxY: (frame.height - defaultSize.1),
            width: defaultSize.0,
            height: defaultSize.1
        )
    }
    
    /// no use
    @objc func backgroundTapHandler(_ recognizer: UITapGestureRecognizer) { }
    
    // MARK: - UIGestureRecognizerDelegate implementation
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let rect = touches.first?.view as? Rectangle {
            rect.isSelected = true
            delegate?.changeCurrentSelected(rect, parent: parent)
        } else {
            delegate?.changeCurrentSelected(nil, parent: parent)
        }
    }
}
