//
//  Plane.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation

/// MainScreenViewController의 탭 신호를 Plane객체가 받기 위해 선언하는 Protocol입니다.
protocol RectangleViewTapDelegate {
    /// 해당 메소드를 구현하여, 터치된 뷰에 해당하는 모델을 parentViewController에 전달합니다.
    ///
    /// parentViewController에 전달을 위해 PlaneAdmitDelegate 를 호출하게 됩니다.
    func changeCurrentSelected(at index: Int?)
}

/// ViewController와 MainScreenViewController 사이를 잇고, 생성된 사각형의 모델들을 저장하는 모델입니다.
final class Plane: RectangleViewTapDelegate {
    
    private let factory = FactoryRectangleProperty()
    private var properties = [RectangleProperty]()
    
    var screenDelegate: MainScreenDelegate?
    
    // Plane 객체는 같은 방식으로 Notification을 보내는 것이 좋다고 생각해서
    // Notification post 만 하는 메소드를 따로 빼서 사용하도록 하였습니다.
    private func sendNotification(_ model: RectangleProperty, at index: Int, as type: MainScreenAction) {
        NotificationCenter.default.post(name: .MainScreenAction, object: model, userInfo: ["index": index, "type": type])
    }
    
    // MARK: - MainScreenDelegate implementation
    func addRectangle() {
        guard
            let factoryProperty = screenDelegate?.getScreenViewProperty(),
            let property = factory.makeRandomView(as: "Subview #\(properties.count)", property: factoryProperty)
        else {
                return
        }
        properties.append(property)
        
        sendNotification(property, at: properties.endIndex-1, as: .AddButtonPushed)
    }
    
    func setRandomColor(at index: Int) -> RectRGBColor? {
        guard
            properties.count-1 >= index,
            let color = properties[index].resetRGBColor()
        else {
            return nil
        }
        
        sendNotification(properties[index], at: index, as: .ColorButtonPushed)
        
        return color
    }
    
    func setAlpha(value: Float, at index: Int) {
        guard properties.count-1 >= index else { return }
        let model = properties[index]
        model.setAlpha(Double(value))
        
        sendNotification(model, at: index, as: .SliderMoved)
    }
    
    // MARK: - RectangleViewTapDelegate implementation
    func changeCurrentSelected(at index: Int?) {
        
        guard let index = index else {
            NotificationCenter.default.post(name: .MainScreenTouched, object: nil, userInfo: nil)
            return
        }
        let model = properties.count-1 >= index ? properties[index] : nil
        
        NotificationCenter.default.post(name: .MainScreenTouched, object: model, userInfo: ["index": index as Any])
    }
    
    // MARK: - Plane no using Interface
    func addProperties(_ model: RectangleProperty) {
        properties.append(model)
    }
    
    func getRectangleCount() -> Int {
        properties.count
    }
    
    func getRectangleProperty(at index: Int) -> RectangleProperty? {
        guard properties.count-1 >= index else {
            return nil
        }
        
        return properties[index]
    }
    
    func hasAnyRectangle(in rect: RectOrigin) -> Bool {
        properties.contains {
            
            let point = $0.point
            let size = $0.size
            
            return point.x >= rect.x
            && point.y >= rect.y
            && point.x+size.width <= rect.x
            && point.y+size.height <= rect.y
        }
    }
    
    /// root view의 액션 타입
    ///
    /// ViewController -> Plane -> MainScreenViewController
    enum MainScreenAction {
        /// 무작위 색상 버튼을 선택
        case ColorButtonPushed
        /// 투명도 슬라이더 움직임
        case SliderMoved
        /// 사각형 추가 버튼을 선택
        case AddButtonPushed
    }
}
