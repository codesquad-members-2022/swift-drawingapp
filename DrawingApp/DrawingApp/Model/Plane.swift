//
//  Plane.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/03.
//

import Foundation

struct Plane {
    private var items = [String: Rectangle]()
    
    var countItems: Int {
        return self.items.count
    }
    
    subscript(id id: String) -> Rectangle? {
        return self.items[id]
    }
    
    /**
     매개변수 point 를 포함하는 사각형을 찾아 반환합니다.
     결과값이 없으면 nil 을 리턴, 여러개인 경우에는 첫번째 요소를 반환합니다.
     */
    func findItemBy(point: Point) -> Rectangle? {
        for rectangle in self.items.values {
            if rectangle.contains(point: point) {
                return rectangle
            }
        }
        
        return nil
    }
    
    mutating func append(item: Rectangle) {
        self.items.updateValue(item, forKey: item.id)
    }
}
