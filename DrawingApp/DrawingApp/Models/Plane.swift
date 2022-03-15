//
//  Plane.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation

// RectangleViewTapDelegate는 문맥 상 어떤 객체에 메시지를 보내는지 확실치 않아서
// MainScreenTapDelegate로 더 명확히 하였습니다.
protocol MainSceneTapDelegate {
    // 델리게이트 패턴의 메소드는 어떤 요소가 언제 누가 선택되었는지 명시하기 위해 네이밍을 변경하였습니다.
    func didSelect(at index: Int?)
}

/// ViewController와 MainScreenViewController 사이를 잇고, 생성된 사각형의 모델들을 저장하는 모델입니다.
final class Plane: MainSceneTapDelegate {
    
    // MARK: - Notification Names
    static let addButtonPushed = Notification.Name.init(rawValue: "addButtonPushed")
    static let colorButtonPushed = Notification.Name.init(rawValue: "colorButtonPushed")
    static let sliderMoved = Notification.Name.init(rawValue: "sliderMoved")
    static let alphaDidChanged = Notification.Name.init(rawValue: "alphaDidChanged")
    static let selectStatusChanged = Notification.Name.init(rawValue: "selectStatusChanged")
    static let rectangleViewTouched = Notification.Name(rawValue: "rectangleViewTouched")
    
    // MARK: - Models for Rectangle View
    private let factory = FactoryRectangleProperty()
    private var rectangleModels = [RectangleProperty]()
    private var selectedIndex: Int?
    
    // MARK: - Initialize Plane & sceneRect
    var sceneRect: RectangleRect!
    init(sceneWidth: Double, sceneHeight: Double) {
        let rectSize = (width: RectangleDefaultSize.width.rawValue, height: RectangleDefaultSize.height.rawValue)
        
        sceneRect = RectangleRect(
            maxX: (sceneWidth - rectSize.width),
            maxY: (sceneHeight - rectSize.height),
            width: rectSize.width,
            height: rectSize.height
        )
    }
    
    // MARK: - Utility of sending notification
    private func sendNotificationToScreen(using name: Notification.Name, sends model: RectangleProperty, at index: Int) {
        NotificationCenter.default.post(
            name: name,
            object: self,
            userInfo: [PostKey.index: index, PostKey.model: model]
        )
    }
    
    // MARK: - MainScreenDelegate implementation
    func addRectangle() {
        guard let rectangleModel = factory.makeRandomRectangleModel(as: "Subview #\(rectangleModels.count)", rectangleRect: sceneRect) else {
            return
        }
        rectangleModels.append(rectangleModel)
        
        sendNotificationToScreen(using: Plane.addButtonPushed, sends: rectangleModel, at: rectangleModels.endIndex-1)
    }
    
    func resetRandomColor(at index: Int) -> RectRGBColor? {
        guard
            rectangleModels.count-1 >= index,
            let color = rectangleModels[index].resetRGBColor()
        else {
            return nil
        }
        
        sendNotificationToScreen(using: Plane.colorButtonPushed, sends: rectangleModels[index], at: index)
        
        return color
    }
    
    func setAlpha(value: Float, at index: Int) {
        guard rectangleModels.count-1 >= index else { return }
        let model = rectangleModels[index]
        model.setAlpha(Double(value))
        
        sendNotificationToScreen(using: Plane.sliderMoved, sends: model, at: index)
        NotificationCenter.default.post(
            name: Plane.alphaDidChanged,
            object: self,
            userInfo: [PostKey.index: index, PostKey.model: model]
        )
    }
    
    // MARK: - RectangleViewTapDelegate implementation
    func didSelect(at index: Int?) {
        selectedIndex = index
        NotificationCenter.default.post(
            name: Plane.selectStatusChanged,
            object: self,
            userInfo: [PostKey.index: (selectedIndex ?? -1)]
        )
        
        var planeNoti = Notification(name: Plane.rectangleViewTouched, object: self, userInfo: nil)
        if let index = index, rectangleModels.count-1 >= index {
            planeNoti.userInfo = [
                PostKey.index: index,
                PostKey.model: rectangleModels[index]
            ]
        }
        
        NotificationCenter.default.post(planeNoti)
    }
    
    // MARK: - Plane no using Interface
    func addProperty(_ model: RectangleProperty) {
        rectangleModels.append(model)
    }
    
    func getRectangleCount() -> Int {
        rectangleModels.count
    }
    
    func getRectangleProperty(at index: Int) -> RectangleProperty? {
        guard rectangleModels.count-1 >= index else {
            return nil
        }
        
        return rectangleModels[index]
    }
    
    func hasAnyRectangle(in rect: RectOrigin) -> Bool {
        rectangleModels.contains {
            
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
        case select = "select"
    }
}
