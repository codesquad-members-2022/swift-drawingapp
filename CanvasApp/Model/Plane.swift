//
//  Plane.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/15.
//

import Foundation
import CoreGraphics

protocol MakerablePlane {
    func addRect(_ element: Rectangle)
    func addPicture(_ element: Picture)
    func addDrawing(_ element: Drawing)
}

protocol TouchablePlane {
    func select(at Point: CGPoint) -> BaseRect?
    func deselect()
    func changeColor(of: CGColor)
    func changeAlpha(to: RectAlpha)
}

protocol ObjectSelectablePlane {
    func select(at index: Int) -> BaseRect?
    func isSelected(id: UUID) -> Bool
}

class Plane : NSObject, MakerablePlane, TouchablePlane, ObjectSelectablePlane {
    enum Notifications {
        static let addedNewRectangle = Notification.Name("added.New.Rectangle")
        static let addedNewPicture = Notification.Name("added.New.Picture")
        static let addedNewDrawing = Notification.Name("added.New.Drawing")

        static let didSelectRectangle = Notification.Name("did.select.Rectangle")
        static let didDeselectRectangle = Notification.Name("did.deselect.Rectangle")

        static let didChangeColor = Notification.Name("did.change.Color")
        static let didChangeAlpha = Notification.Name("did.change.Alpha")
    }

    enum Keys {
        static let Element = "Element"
    }

    private var objects : [BaseRect]
    private var selected : BaseRect? = nil
    
    override init() {
        self.objects = [BaseRect]()
    }
    
    private func append(_ element: BaseRect) {
        self.objects.append(element)
    }
    
    func addRect(_ element: Rectangle) {
        self.append(element)
        NotificationCenter.default.post(name: Self.Notifications.addedNewRectangle, object: self, userInfo: [Keys.Element: element])
    }
    
    func addPicture(_ element: Picture) {
        self.append(element)
        NotificationCenter.default.post(name: Self.Notifications.addedNewPicture, object: self, userInfo: [Keys.Element: element])
    }
    
    func addDrawing(_ element: Drawing) {
        self.append(element)
        NotificationCenter.default.post(name: Self.Notifications.addedNewDrawing, object: self, userInfo: [Keys.Element: element])
    }
    
    func remove(item: BaseRect) -> Bool {
        return true
    }
        
    func moveForward(at: Int) -> Bool {
        return true
    }
    
    func moveBackword(at: Int) -> Bool {
        return true
    }
    
    func select(at index: Int) -> BaseRect? {
        let rect = objects[index]
        selected = rect
        NotificationCenter.default.post(name: Self.Notifications.didSelectRectangle, object: self, userInfo: [Keys.Element: rect])
        return selected
    }
    
    func select(at point: CGPoint) -> BaseRect? {
        for rect in objects.reversed() {
            let box = CGRect(origin: rect.origin, size: rect.size)
            if box.contains(point) {
                selected = rect
                NotificationCenter.default.post(name: Self.Notifications.didSelectRectangle, object: self, userInfo: [Keys.Element: rect])
                return rect
            }
        }
        selected = nil
        return nil
    }
    
    func deselect() {
        NotificationCenter.default.post(name: Self.Notifications.didDeselectRectangle, object: self, userInfo: nil)
        selected = nil
    }
    
    func isSelected(id: UUID) -> Bool {
        return (self.selected?.id == id)
    }
    
    func changeColor(of value: CGColor) {
        guard let selected = self.selected as? RectColorful else { return }
        selected.changeColor(with: value)
        NotificationCenter.default.post(name: Self.Notifications.didChangeColor, object: self, userInfo: [Keys.Element: selected])
    }
    
    func changeAlpha(to value: Rectangle.AlphaStep) {
        guard let selected = self.selected as? RectAlphaful else { return }
        selected.changeAlpha(to: value)
        NotificationCenter.default.post(name: Self.Notifications.didChangeAlpha, object: self, userInfo: [Keys.Element: selected])
    }

}


extension Plane: ObjectsIteratable {
    var count: Int {
        return objects.count
    }
    
    func object(at index: Int) -> ObjectDescription? {
        let rect = objects[index] as? ObjectDescription
        return rect
    }
    
    
}
