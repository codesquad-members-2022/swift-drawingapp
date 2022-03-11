//
//  Plane.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation

// RectangleViewTapDelegate는 문맥 상 어떤 객체에 메시지를 보내는지 확실치 않아서
// MainScreenTapDelegate로 더 명확히 하였습니다.
protocol MainScreenTapDelegate {
    // 델리게이트 패턴의 메소드는 어떤 요소가 언제 누가 선택되었는지 명시하기 위해 네이밍을 변경하였습니다.
    func mainScreenRectangleDidSelect(at index: Int?)
}

/// ViewController와 MainScreenViewController 사이를 잇고, 생성된 사각형의 모델들을 저장하는 모델입니다.
final class Plane: MainScreenTapDelegate {
    
    static let alphaDidChanged = Notification.Name.init(rawValue: "alphaDidChanged")
    
    private let factory = FactoryRectangleProperty()
    private var properties = [RectangleProperty]()
    
    var screenDelegate: MainScreenDelegate?
    
    private func sendNotificationToScreen(using name: Notification.Name, sends model: RectangleProperty, at index: Int) {
        NotificationCenter.default.post(
            name: name,
            object: type(of: self),
            userInfo: [PostKey.index: index, PostKey.model: model]
        )
    }
    
    // MARK: - MainScreenDelegate implementation
    func addRectangle() {
        guard
            let randomRectangleProperty = screenDelegate?.getScreenViewProperty(),
            let rectangleViewProperty = factory.makeRandomView(as: "Subview #\(properties.count)", property: randomRectangleProperty)
        else {
                return
        }
        properties.append(rectangleViewProperty)
        
        sendNotificationToScreen(using: MainViewController.addButtonPushed, sends: rectangleViewProperty, at: properties.endIndex-1)
    }
    
    func resetRandomColor(at index: Int) -> RectRGBColor? {
        guard
            properties.count-1 >= index,
            let color = properties[index].resetRGBColor()
        else {
            return nil
        }
        
        sendNotificationToScreen(using: MainViewController.colorButtonPushed, sends: properties[index], at: index)
        
        return color
    }
    
    func setAlpha(value: Float, at index: Int) {
        guard properties.count-1 >= index else { return }
        let model = properties[index]
        model.setAlpha(Double(value))
        
        sendNotificationToScreen(using: MainViewController.sliderMoved, sends: model, at: index)
        NotificationCenter.default.post(
            name: Plane.alphaDidChanged,
            object: self,
            userInfo: [PostKey.index: index, PostKey.model: model]
        )
    }
    
    // MARK: - RectangleViewTapDelegate implementation
    func mainScreenRectangleDidSelect(at index: Int?) {
        var planeNoti = Notification(name: MainScreenViewController.rectangleViewTouched, object: self, userInfo: nil)
        if let index = index, properties.count-1 >= index {
            planeNoti.userInfo = [
                PostKey.index: index,
                PostKey.model: properties[index]
            ]
        }
        
        NotificationCenter.default.post(planeNoti)
    }
    
    // MARK: - Plane no using Interface
    func addProperty(_ model: RectangleProperty) {
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
    
    /// Notification을 post 할 때 userInfo에서 사용할 용도로 만든 Nested Type
    ///
    /// Plane 객체 내의 static let 등을 이용하여 만들 수도 있지만
    enum PostKey: String {
        case index = "index"
        case type = "type"
        case model = "model"
    }
}
