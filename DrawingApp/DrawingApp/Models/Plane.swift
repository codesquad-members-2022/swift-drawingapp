//
//  Plane.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation
import UIKit

/// MainScreenViewController의 탭 신호를 Plane객체가 받기 위해 선언하는 Protocol입니다.
protocol RectangleViewTapDelegate {
    /// 해당 메소드를 구현하여, 터치된 뷰에 해당하는 모델을 parentViewController에 전달합니다.
    func changeCurrentSelected(_ rectangle: Rectangle?, parent: UIViewController?)
}

/// ViewController와 MainScreenViewController 사이를 잇고, 생성된 사각형의 모델들을 저장하는 모델입니다.
final class Plane: RectangleViewTapDelegate {
    
    let factory = FactoryRectangleProperty()
    var screenDelegate: MainScreenDelegate?
    var planeDelegate: PlaneAdmitDelegate?
    
    private var properties = [RectangleProperty]()
    /// Plane객체는 해당 변수를 이용해 선택된 뷰, 선택이 해제될 뷰를 관리합니다.
    var current: Rectangle?
    
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
    
    // MARK: - Edit properties (ViewContoller use properties)
    
    func setProperty(at index: Int, alpha: Float) {
        guard properties.count-1 >= index else { return }
        properties[index].setAlpha(Double(alpha))
    }
    
    func setProperty(at index: Int, size: RectSize) {
        guard properties.count-1 >= index else { return }
        properties[index].setSize(size)
    }
    
    func setProperty(at index: Int, point: RectOrigin) {
        guard properties.count-1 >= index else { return }
        properties[index].setPoint(point)
    }
    
    // MARK: - MainScreenDelegate implementation
    
    func addRectangle() {
        guard let factoryProperty = screenDelegate?.getScreenViewProperty(), let property = factory.makeRandomView(as: "Subview #\(properties.count)", property: factoryProperty) else {
            return
        }
        properties.append(property)
        screenDelegate?.addRectangle(using: property, index: properties.endIndex-1)
    }
    
    func setRandomColor() -> RectRGBColor? {
        guard let current = current, let color = factory.generateRandomRGBColor() else { return nil }
        
        screenDelegate?.admitColor(
            to: current,
            using: color,
            alpha: properties[current.index].alpha
        )
        return color
    }
    
    func setAlpha(value: Float) {
        guard let current = current else { return }
        screenDelegate?.admitAlpha(to: current, using: value)
    }
    
    // MARK: - RectangleViewTapDelegate implementation
    func changeCurrentSelected(_ rectangle: Rectangle?, parent: UIViewController?) {
        
        current?.isSelected = false
        current = rectangle
        
        if let rect = rectangle, properties.count >= rect.index+1 {
            planeDelegate?.admitPlane(property: properties[rect.index])
        } else {
            planeDelegate?.admitDefault()
        }
    }
}
