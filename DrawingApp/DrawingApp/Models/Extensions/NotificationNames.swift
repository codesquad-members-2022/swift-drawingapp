//
//  NotificationNames.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/16.
//

import Foundation

extension Notification.Name {
    static let newShapeDidCreate = NSNotification.Name("NewShapeDidCreateNotification")
    static let shapeDidSelect = NSNotification.Name("ShapeDidSelectNotification")
    static let emptyViewDidSelect = NSNotification.Name("EmptyViewDidSelectNotification")

    static let selectedShapeDidChange = NSNotification.Name("SelectedShapeDidChangeNotification")
    static let selectedShapeDidUpdateBackgroundColor = NSNotification.Name("SelectedShapeDidUpdateBackgroundColorNotification")
    static let selectedShapeDidUpdateAlpha = NSNotification.Name("SelectedShapeDidUpdateAlphaNotification")
}
