//
//  Plane.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/03.
//

import Foundation

struct Plane {
    private var items = [String: Rectangle]()
    
    private(set) var currentItem: Rectangle? {
        willSet {
            guard let item = self.currentItem else { return }
            self.notifyDidUnselectItem(item)
        }
        didSet {
            self.notifyDidSelectItem()
        }
    }
    
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
        item.postDidCreated()
    }
    
    mutating func selectItem(id: String) {
        guard let item = self.items[id] else { return }
        self.currentItem = item
    }
    
    mutating func unselectItem() {
        self.currentItem = nil
    }
}

// MARK: - Notification
extension Plane {
    enum NotificationKey {
        case select
        case unselect
    }
    
    func notifyDidSelectItem() {
        guard let item = self.currentItem else { return }
        print("ITEM: ",item.origin)
        NotificationCenter.default.post(name: .PlaneDidSelectItem, object: self, userInfo: [Self.NotificationKey.select: item])
    }
    
    func notifyDidUnselectItem(_ item: Rectangle) {
        NotificationCenter.default.post(name: .PlaneDidUnselectItem, object: self, userInfo: [Self.NotificationKey.unselect: item])
    }
}
