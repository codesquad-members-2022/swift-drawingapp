//
//  Plane.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/02.
//

import Foundation
import OSLog
import UIKit


protocol PlaneDelegate {
//    func didAppendModel(model: Model?)
    func didSelectModel(currentModel: Model?, previousModel : Model?)
    func didRandomizeColor(model : Model)
    func didChangeAlpha(model: Model)
    
}

class Plane {
    var delegate : PlaneDelegate?
    private var models = [Model]()
    private let size: Size
    private let point: Point
    private var selectedModel : Model? {
        didSet {
            //pre -> false, current -> ture
            if selectedModel != oldValue {
                oldValue?.configureSelected(to: false)
            }
            delegate?.didSelectModel(currentModel: selectedModel, previousModel : oldValue)
        }
    }
    var numberOfModel : Int {
        self.models.count
    }
    subscript(index: Int) -> Model?{
        get {
            guard numberOfModel > index , -1 > index else {return nil}
            return models[index]
        }
    }
    
    init(planeSize : Size, safeAreaInsets: Point) {
        self.size = planeSize
        self.point = safeAreaInsets
    }
    
    
    func addModel() {
        let newModel = Factory.makeRect(planePoint: point, planeSize: size, modelSize: Size(width: 130, height: 120))
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
        delegate?.didRandomizeColor(model: targetModel)
    }
    
    func changeAlphaOnSelectedModel(to alpha: Alpha?){
        guard let newAlpha = alpha , let targetModel = selectedModel else{return}
        targetModel.updateAlpha(newAlpha)
        delegate?.didChangeAlpha(model: targetModel)
    }

}


