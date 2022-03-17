//
//  Plane.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/02.
//

import Foundation

class Plane{
    private var customViewModelFactory: CustomViewFactoryResponse
    private var models: [CustomViewModelMutable] = []
    private(set) var selectedModel: CustomViewModelMutable?
    
    subscript(point: ViewPoint) -> CustomViewModelMutable?{
        return findModelByPoint(point: point)
    }
    
    init(rectangleFactory: CustomViewFactoryResponse){
        self.customViewModelFactory = rectangleFactory
    }
    
    private func addRectangle(){
        let rectangleMutable = customViewModelFactory.randomRectangleViewModel()
        models.append(rectangleMutable)
        self.selectedModel = rectangleMutable
        NotificationCenter.default.post(name: Plane.Notification.Event.addedRectangle, object: self, userInfo: [Plane.Notification.Key.rectangle : rectangleMutable])
    }
    
    private func addPhoto(imageData: Data){
        let photoMutable = customViewModelFactory.randomPhotoViewModel(imageData: imageData)
        models.append(photoMutable)
        self.selectedModel = photoMutable
        NotificationCenter.default.post(name: Plane.Notification.Event.addedPhoto, object: self, userInfo: [Plane.Notification.Key.photo : photoMutable])
        
    }
    
    private func changeRectangleColor(){
        guard let rectangle = selectedModel as? RectangleViewModelMutable else {
            return
        }
        let rectangleMutable = customViewModelFactory.randomRectangleViewModel()
        let rgbValue = rectangleMutable.getColorRGB()
        rectangle.resetColor(rgbValue: rgbValue)
        NotificationCenter.default.post(name: Plane.Notification.Event.changedRectangleColor, object: self, userInfo:  [Plane.Notification.Key.rectangle : rectangle])
    }
    
    private func selectedCustomView(point: ViewPoint){
        guard let selectedModel = findModelByPoint(point: point) else { return }
        self.selectedModel = selectedModel
        if let photoMutable = selectedModel as? PhotoViewModelMutable{
            NotificationCenter.default.post(name: Plane.Notification.Event.selectedPhoto, object: self, userInfo: [Plane.Notification.Key.photo : photoMutable])
        }
        if let ractangleMutable = selectedModel as? RectangleViewModelMutable{
            NotificationCenter.default.post(name: Plane.Notification.Event.selectedRectangle, object: self, userInfo: [Plane.Notification.Key.rectangle : ractangleMutable])
        }
    }
    
    private func deselectedCustomView(){
        self.selectedModel = nil
        NotificationCenter.default.post(name: Plane.Notification.Event.deselectedCustomView, object: self)
    }
    
    private func plusAlpha(){
        guard let selectedModel = selectedModel else {
            return
        }
        selectedModel.changeAlphaValue(alpha: selectedModel.getAlpha() + 0.1)
        NotificationCenter.default.post(name: Plane.Notification.Event.updateCustomViewAlpha, object: self, userInfo: [Plane.Notification.Key.customViewModel : selectedModel])
    }
    
    private func minusAlpha(){
        guard let selectedModel = selectedModel else {
            return
        }
        selectedModel.changeAlphaValue(alpha: selectedModel.getAlpha() - 0.1)
        NotificationCenter.default.post(name: Plane.Notification.Event.updateCustomViewAlpha, object: self, userInfo: [Plane.Notification.Key.customViewModel : selectedModel])
    }
    
    private func findModelByPoint(point: ViewPoint) -> CustomViewModelMutable?{
        for model in models{
            if model.isPointInArea(point: point){
                return model
            }
        }
        return nil
    }
    
    enum Notification{
        enum Key{
            case rectangle
            case photo
            case customViewModel
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
extension Plane: PlaneModelManageable{
    func deSelectTargetCustomView() {
        deselectedCustomView()
    }
    
    func selectTargetCustomView(point: ViewPoint) {
        selectedCustomView(point: point)
    }
    
    func addRandomRectnagleViewModel() {
        addRectangle()
    }
    
    func addRandomPhotoViewModel(imageData: Data) {
        addPhoto(imageData: imageData)
    }
    
    func plusCustomViewAlpha() {
        plusAlpha()
    }
    
    func changeRectangleRandomColor(){
        changeRectangleColor()
    }
    
    func minusCustomViewAlpha() {
        minusAlpha()
    }
    
    func rectangleCount() -> Int{
        return models.count
    }
}
