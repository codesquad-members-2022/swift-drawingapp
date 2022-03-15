//
//  Plane.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

class Plane{
    private var customViewModelFactory: CustomViewFactoryResponse
    private var models: [ViewPoint: CustomViewEntity] = [:]
    private(set) var selectedModel: CustomViewEntity?
    private(set) var selectedCustomViewType: CustomViewType = .none
    
    subscript(point: ViewPoint) -> CustomViewEntity?{
        return models[point]
    }
    
    init(rectangleFactory: CustomViewFactoryResponse){
        self.customViewModelFactory = rectangleFactory
    }
    
    private func addRectangle(){
        let rectangleMutable = customViewModelFactory.randomRectangle()
        let rectangle = rectangleMutable.getRandomRectangle()
        self.models[rectangle.point] = rectangle
        self.selectedModel = rectangle
        selectedCustomViewType = .rectangle
        NotificationCenter.default.post(name: Plane.Notification.Event.addedRectangle, object: self, userInfo: [Plane.Notification.Key.rectangle : rectangle])
    }
    
    private func addPhoto(imageData: Data){
        let photoMutable = customViewModelFactory.randomPhoto(imageData: imageData)
        let photo = photoMutable.getRandomPhoto()
        self.models[photo.point] = photo
        self.selectedModel = photo
        selectedCustomViewType = .photo
        NotificationCenter.default.post(name: Plane.Notification.Event.addedPhoto, object: self, userInfo: [Plane.Notification.Key.photo : photo])
    }
    
    private func changeRectangleColor(){
        guard let rectangle = selectedModel as? Rectangle else {
            return
        }
        let colorMuatble = customViewModelFactory.randomRGBColor()
        let rgbValue = colorMuatble.getRandomColorRGb()
        rectangle.resetColor(rgbValue: rgbValue)
        NotificationCenter.default.post(name: Plane.Notification.Event.changedRectangleColor, object: self, userInfo:  [Plane.Notification.Key.rectangle : rectangle])
    }
    
    private func selectedCustomView(point: ViewPoint){
        self.selectedModel = models[point]
        print("selected Something")
        if let photo = selectedModel as? Photo{
            print("its photo")
            NotificationCenter.default.post(name: Plane.Notification.Event.selectedPhoto, object: self, userInfo: [Plane.Notification.Key.photo : photo])
        }
        if let rectangle = selectedModel as? Rectangle{
            NotificationCenter.default.post(name: Plane.Notification.Event.selectedRectangle, object: self, userInfo: [Plane.Notification.Key.rectangle : rectangle])
        }
        
        
        
    }
    
    private func deselectedCustomView(){
        self.selectedModel = nil
        self.selectedCustomViewType = .none
        NotificationCenter.default.post(name: Plane.Notification.Event.deselectedCustomView, object: self)
    }
    
    private func plusAlpha(){
        guard let selectedModel = selectedModel else {
            return
        }
        selectedModel.changeAlphaValue(alpha: selectedModel.alpha + 0.1)
        NotificationCenter.default.post(name: Plane.Notification.Event.updateCustomViewAlpha, object: self, userInfo: [Plane.Notification.Key.customViewEntity : selectedModel])
    }
    
    private func minusAlpha(){
        guard let selectedModel = selectedModel else {
            return
        }
        selectedModel.changeAlphaValue(alpha: selectedModel.alpha - 0.1)
        NotificationCenter.default.post(name: Plane.Notification.Event.updateCustomViewAlpha, object: self, userInfo: [Plane.Notification.Key.customViewEntity : selectedModel])
    }
    
}
extension Plane: CustomEntitiesChangeable{
    func deSelectTargetCustomView() {
        deselectedCustomView()
    }
    
    func selectTargetCustomView(point: ViewPoint) {
        selectedCustomView(point: point)
    }
    
    func addRandomRectnagle() {
        addRectangle()
    }
    
    func addRandomPhoto(imageData: Data) {
        addPhoto(imageData: imageData)
    }
    
    func plusCustomViewAlpha() {
        plusAlpha()
    }
    
    func changeRectangleRandomColor(){
        changeRectangleColor()
    }
    
    func CustomViewAlpha() {
        minusAlpha()
    }
    
    func rectangleCount() -> Int{
        return models.count
    }
    
    enum Notification{
        enum Key{
            case rectangle
            case photo
            case customViewEntity
        }
        enum Event{
            static let addedRectangle = Foundation.Notification.Name.init("addedRectangle")
            static let selectedRectangle = Foundation.Notification.Name.init("selectedRectangle")
            static let selectedPhoto = Foundation.Notification.Name.init("selectedPhoto")
            static let deselectedCustomView = Foundation.Notification.Name.init("deselectedCustomView")
            static let changedRectangleColor = Foundation.Notification.Name.init("changedRectangleColor")
            static let updateCustomViewAlpha = Foundation.Notification.Name.init("updateRectangleAlpha")
            static let addedPhoto = Foundation.Notification.Name.init("addedPhoto")
        }
    }
}
