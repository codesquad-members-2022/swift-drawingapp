//
//  Plane.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/04.
//

import Foundation

class Plane {
    
    private var shapes: [BasicShape] = []
    private var selected: BasicShape?
    
    subscript(index: Int) -> BasicShape {
        return shapes[index]
    }
    
    var count: Int {
        return shapes.count
    }
    
    func addRectangle(bound: (x: Double, y: Double), by factoryType: ShapeFactory.Type) {
        let newRectangle = factoryType.createRandomRectangle(xBound: bound.x, yBound: bound.y)
        shapes.append(newRectangle)
        NotificationCenter.default.post(name: Plane.EventName.newShapeDidCreate,
                                        object: self,
                                        userInfo: [UserInfoKeys.newRectangle: newRectangle])
    }
    
    func addPicture(bound: (x: Double, y: Double), by factoryType: ShapeFactory.Type) {
        
    }
    
    func updateSelected(shape: BasicShape) {
        selected = shape
        NotificationCenter.default.post(name: Plane.EventName.selectedShapeDidChange,
                                        object: self,
                                        userInfo: [UserInfoKeys.updatedSelectedShape: shape])
    }
    
    func clearSelected() {
        selected = nil
    }

    func searchTopShape(on coordinate: (x: Double, y: Double)) {
        let previouslySelected = selected
        
        for shape in shapes.reversed() {
            if shape.isExist(on: coordinate) {
                let newlySelected = shape
                
                NotificationCenter.default.post(name: Plane.EventName.shapeDidSelect,
                                                object: self,
                                                userInfo: [UserInfoKeys.previouslySelectedShape: previouslySelected as Any,
                                                           UserInfoKeys.newlySelectedShape: newlySelected])
                return
            }
        }
        
        NotificationCenter.default.post(name: Plane.EventName.emptyViewDidSelect,
                                        object: self,
                                        userInfo: [UserInfoKeys.previouslySelectedShape: previouslySelected as Any])
    }
    
    func changeBackgroundColor() {
        guard let selectedShape = selected as? BasicShape & Colorable else { return }
        let randomColor = RandomAttributeFactory.generateRandomColor()
        selectedShape.changeBackgroundColor(by: randomColor)
        NotificationCenter.default.post(name: Plane.EventName.selectedShapeDidUpdateBackgroundColor,
                                        object: self,
                                        userInfo: [UserInfoKeys.selectedShape: selectedShape])
    }
    
    func upAlphaValue() {
        guard let selectedShape = selected as? BasicShape & Alphable else { return }
        selectedShape.upAlphaLevel()
        NotificationCenter.default.post(name: Plane.EventName.selectedShapeDidUpdateAlpha,
                                        object: self,
                                        userInfo: [UserInfoKeys.selectedShape: selectedShape])
    }
    
    func downAlphaValue() {
        guard let selectedShape = selected as? BasicShape & Alphable else { return }
        selectedShape.downAlphaLevel()
        NotificationCenter.default.post(name: Plane.EventName.selectedShapeDidUpdateAlpha,
                                        object: self,
                                        userInfo: [UserInfoKeys.selectedShape: selectedShape])
    }
}

//MARK: Notifications

extension Plane {
    enum UserInfoKeys {
        static let newRectangle = "NewRectangle"
        static let updatedSelectedShape = "UpdatedSelectedShape"
        static let newlySelectedShape = "NewlySelectedShape"
        static let previouslySelectedShape = "PreviouslySelectedShape"
        static let selectedShape = "SelectedShape"
    }
    
    enum EventName {
        static let newShapeDidCreate = NSNotification.Name("NewShapeDidCreateNotification")
        static let shapeDidSelect = NSNotification.Name("ShapeDidSelectNotification")
        static let emptyViewDidSelect = NSNotification.Name("EmptyViewDidSelectNotification")

        static let selectedShapeDidChange = NSNotification.Name("SelectedShapeDidChangeNotification")
        static let selectedShapeDidUpdateBackgroundColor = NSNotification.Name("SelectedShapeDidUpdateBackgroundColorNotification")
        static let selectedShapeDidUpdateAlpha = NSNotification.Name("SelectedShapeDidUpdateAlphaNotification")
    }
}

