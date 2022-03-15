//
//  Plane.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
import OSLog
import UIKit

protocol ModelManagable {
    var models : [Model] {get}
    var modelFactory : ModelProducible {get}
    func addModel()
    func selectModel(tapCoordinate: Point)
    func randomizeColorOnSelectedModel()
    func changeAlphaOnSelectedModel(to alpha: Alpha?)
    init(modelFactory : ModelProducible)
}


class Plane : ModelManagable {
    private (set) var models = [Model]()
    private (set) var modelFactory : ModelProducible
    private var selectedModel : Model? {
        didSet {
            //pre -> false, current -> ture
            if selectedModel != oldValue {
                oldValue?.configureSelected(to: false)
            }
            NotificationCenter.default.post(name: .DidSelectModel, object: self, userInfo: [UserInfo.currentModel: selectedModel as Any, UserInfo.previousModel: oldValue as Any]
            )
        }
    }
    var numberOfModel : Int {
        self.models.count
        
    }
    subscript(index: UInt64) -> Modellable?{
        get {
            guard numberOfModel > index else {return nil}
            return models[Int(index)]
        }
    }
    
    required init(modelFactory : ModelProducible) {
        self.modelFactory = modelFactory
    }
    
    
    func addModel() {
        let newModel = modelFactory.make(size: Size(width: 130, height: 120))
        self.models.append(newModel)
        NotificationCenter.default.post(name: .DidMakeModel, object: self, userInfo: [UserInfo.model: newModel])
    }

    func selectModel(tapCoordinate: Point) {
        
        var detectedModel : Model?
        for model in models {
            let minX = model.point.x
            let minY = model.point.y
            let maxX = model.point.x + model.size.width
            let maxY = model.point.y + model.size.height
            
            if (minX <= tapCoordinate.x && maxX >= tapCoordinate.x && minY <= tapCoordinate.y && maxY >= tapCoordinate.y){
                model.toggleSelected()
                detectedModel = model
            }
        }
        selectedModel = detectedModel
    }
    
    func randomizeColorOnSelectedModel(){
        guard let targetModel = selectedModel else{return}
        targetModel.updateColor(RandomGenerator.makeColor())
        NotificationCenter.default.post(name: .DidChangeColor, object: self, userInfo: [UserInfo.model : targetModel])
    }
    
    func changeAlphaOnSelectedModel(to alpha: Alpha?){
        guard let newAlpha = alpha , let targetModel = selectedModel else{return}
        targetModel.updateAlpha(newAlpha)
        NotificationCenter.default.post(name: .DidChangeAlpha, object: self, userInfo: [UserInfo.model : targetModel])
    }

}


