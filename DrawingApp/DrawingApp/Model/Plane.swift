//
//  Plane.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/03.
//

import Foundation

struct Plane {
    private var items: [Rectangle] = []
    
    var countItems: Int {
        return self.items.count
    }
    
    subscript(index: Int) -> Rectangle {
        return self.items[index]
    }
    
    func findItemBy(point: Point) -> Rectangle? {
        // TODO: 해당 point 를 포함하는 사각형을 찾는 로직 구현
        return self.items.first
    }
    
    mutating func append(item: Rectangle) {
        self.items.append(item)
    }
}
