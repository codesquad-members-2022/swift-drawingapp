//
//  Notification.Name+Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/09.
//

import Foundation

extension Notification.Name {
    static let RectangleDataDidCreated = Notification.Name("RectangleDataDidCreated")
    static let RectangleDataDidUpdated = Notification.Name("RectangleDataDidUpdated")
    
    static let PlaneDidSelectItem = Notification.Name("PlaneDidSelectItem")
    static let PlaneDidUnselectItem = Notification.Name("PlaneDidUnselectItem")
}
