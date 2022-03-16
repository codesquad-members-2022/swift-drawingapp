//
//  NotificationCenter.swift
//  DrawingApp
//
//  Created by YEONGJIN JANG on 2022/03/16.
//

import Foundation

let notificationCenter = NotificationCenter.default

extension Notification.Name {
    static let addRectangleView = Notification.Name("A rectangle is made")
    static let tappedRectangleView = Notification.Name("a rectangle view is Tapped")
    static let tapAnotherView = Notification.Name("another View Touched")
    static let colorChange = Notification.Name("color changed")
    static let alphaChange = Notification.Name("alpha changed")
}

enum NotificationKey {
    case color
    case alpha
    case tappedRectangle
    case addedRectangle
}
