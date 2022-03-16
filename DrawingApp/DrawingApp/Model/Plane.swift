//
//  Plane.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/03.
//

import Foundation

class Plane {
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
    
    var count: Int {
        return self.items.count
    }
    
    subscript(id id: String) -> Rectangle? {
        return self.items[id]
    }
    
    func findItemBy(point: Point) -> Rectangle? {
        let models = Array(self.items.values)
        
        return models.last(where: { item in
            return item.contains(point: point)
        })
    }
    
    func append(item: Rectangle) {
        self.items.updateValue(item, forKey: item.id)
        item.notifyDidCreated()
    }
    
    func selectItem(id: String) {
        guard let item = self.items[id] else { return }
        self.currentItem = item
    }
    
    func unselectItem() {
        if self.currentItem != nil {
            self.currentItem = nil
        }
    }
}

extension Plane: CustomStringConvertible {
    var description: String {
        return "Count: \(self.count), Items: \(self.items.values.map { (id: $0.id, origin: $0.origin) })"
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
        NotificationCenter.default.post(name: .PlaneDidSelectItem, object: self, userInfo: [Self.NotificationKey.select: item])
    }
    
    func notifyDidUnselectItem(_ item: Rectangle) {
        NotificationCenter.default.post(name: .PlaneDidUnselectItem, object: self, userInfo: [Self.NotificationKey.unselect: item])
    }
}
