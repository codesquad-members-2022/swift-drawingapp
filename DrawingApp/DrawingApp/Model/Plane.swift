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
    
    func findItemBy(point: Point) -> Rectangle? {
        // TODO: 해당 point 를 포함하는 사각형을 찾는 로직 구현
        return nil
    }
    
    mutating func append(item: Rectangle) {
        self.items.updateValue(item, forKey: item.id)
    }
}
