//
//  Plane.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/03.
//

import Foundation

class Plane {
    
    private var properties = [ViewRandomProperty]()
    
    /// ViewController에 생성된 뷰 중 현재 선택된 뷰를 Plane이 관리할 것입니다.
    /// 뷰 선택이 가능하도록 하는 이유는 Plane이 저장하는 프로퍼티의 값을 바꾸고
    /// 그에 따라 바뀐 속성을 해당 뷰에 적용하기 위해서입니다.
    var current: Rectangle?
    
    func addProperties(_ model: ViewRandomProperty) {
        properties.append(model)
    }
    
    func getRectangleCount() -> Int {
        properties.count
    }
    
    func getRectangleProperty(at index: Int) -> ViewRandomProperty? {
        guard properties.count-1 >= index else {
            return nil
        }
        
        return properties[index]
    }
    
    func hasAnyRectangle(in rect: RectPoint) -> Bool {
        properties.contains {
            
            let point = $0.getPoint()
            let size = $0.getSize()
            
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
    
    func setProperty(at index: Int, point: RectPoint) {
        guard properties.count-1 >= index else { return }
        properties[index].setPoint(point)
    }
}
