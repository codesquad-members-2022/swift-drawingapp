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
    static let addViewButtonPushed = Notification.Name.init(rawValue: "addViewButtonPushed")
    static let colorButtonPushed = Notification.Name.init(rawValue: "colorButtonPushed")
    static let sliderMoved = Notification.Name.init(rawValue: "sliderMoved")
    static let alphaDidChanged = Notification.Name.init(rawValue: "alphaDidChanged")
    static let selectStatusChanged = Notification.Name.init(rawValue: "selectStatusChanged")
    static let rectangleViewTouched = Notification.Name(rawValue: "rectangleViewTouched")
    
    // MARK: - Models for Rectangle View
    private let factory: FactoryRectangleProperty
    private var rectangleModels = [RectangleProperty]()
    private var selectedIndex: Int?
    
    private var rectangleName: String {
        return "Subview #\(rectangleModels.count)"
    }
    
    // MARK: - Initialize Plane & sceneRect
    private var sceneRect: ScreenSceneRect!
    init(sceneWidth: Double, sceneHeight: Double) {
        let rectSize = (width: RectangleDefaultSize.width.rawValue, height: RectangleDefaultSize.height.rawValue)
        
        let sceneRect = ScreenSceneRect(
            maxX: (sceneWidth - rectSize.width),
            maxY: (sceneHeight - rectSize.height),
            width: rectSize.width,
            height: rectSize.height
        )
        
        factory = FactoryRectangleProperty(in: sceneRect)
    }
    
    // MARK: - MainScreenDelegate implementation
    func addRectangle(with imageData: Data) {
        guard let rectangleModel = factory.makeRandomRectangleModel(as: rectangleName, imageData: imageData) else {
            return
        }
        
        addProperty(rectangleModel)
    }
    
    func addRectangle() {
        let rectangleModel = factory.makeRandomRectangleModel(as: rectangleName)
        addProperty(rectangleModel)
    }
    
    private func addProperty(_ model: RectangleProperty) {
        rectangleModels.append(model)
        
        NotificationCenter.default.post(
            name: Plane.addViewButtonPushed,
            object: self,
            userInfo: [
                PostKey.index: rectangleModels.endIndex-1,
                PostKey.model: model
            ]
        )
    }
    
    func resetRandomColor(at index: Int) -> RectRGBColor? {
        guard
            (0..<rectangleModels.endIndex) ~= index,
            let color = (rectangleModels[index] as? ColoredRectangleProperty)?.resetRGBColor()
        else {
            return nil
        }
        
        NotificationCenter.default.post(
            name: Plane.colorButtonPushed,
            object: self,
            userInfo: [PostKey.index: index, PostKey.model: rectangleModels[index]]
        )
        
        return color
    }
    
    func setAlpha(value: Float, at index: Int) {
        guard (0..<rectangleModels.endIndex) ~= index else { return }
        let model = rectangleModels[index]
        model.setAlpha(Double(value))
        
        var noti = Notification(name: Plane.sliderMoved, object: self, userInfo: [PostKey.index: index, PostKey.model: model])
        NotificationCenter.default.post(noti) // Plane.sliderMoved
        
        noti.name = Plane.alphaDidChanged
        NotificationCenter.default.post(noti) // Plane.alphaDidChanged
    }
    
    // MARK: - RectangleViewTapDelegate implementation
    func didSelect(at index: Int?) {
        guard -1..<rectangleModels.endIndex ~= (index ?? -1) else {
            return
        }
        
        selectedIndex = index
        
        var noti = Notification(name: Plane.selectStatusChanged, object: self, userInfo: [PostKey.index: (selectedIndex ?? -1)])
        NotificationCenter.default.post(noti) // Plane.selectStatusChanged
        
        noti.name = Plane.rectangleViewTouched
        if let index = index {
            noti.userInfo?[PostKey.model] = rectangleModels[index]
        } else {
            noti.userInfo = nil
        }
        
        NotificationCenter.default.post(noti) // Plane.rectangleViewTouched
    }
    
    // MARK: - Plane no using Interface
    
    func getRectangleCount() -> Int {
        rectangleModels.count
    }
    
    func getRectangleProperty(at index: Int) -> RectangleProperty? {
        guard (0..<rectangleModels.endIndex) ~= index else { return nil }
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
    }
}
