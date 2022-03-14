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
    func didAppendModel(model: Model?)
    func didSelectModel(currentModel: Model?, previousModel : Model?)
    func didRandomizeColor(model : Model)
    func didChangeAlpha(model: Model)
    
}

class Plane{
    
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
    var numberOfRect : Int {
        self.models.count
    }
    subscript(index: Int) -> Model?{
        get {
            guard numberOfRect > index , -1 > index else {return nil}
            return models[index]
        }
    }
    
    init(planeSize : Size, safeAreaInsets: Point) {
        self.size = planeSize
        self.point = safeAreaInsets
    }
    
    
    func addModel() {
        let newRectangle = Factory.makeRect(planePoint: point, planeSize: size, modelSize: Size(width: 130, height: 120))
        self.models.append(newRectangle)
        delegate?.didAppendModel(model: models.last)
    }

    func selectModel(tapCoordinate: Point) {
        
        let reversedArray = self.models.reversed() //가장 위에 있는 모델을 찾기 위해서.
        var detectedModel : Model?
        for model in reversedArray {
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
    
    func randomizeColor(on model: Model){
        model.updateColor(RandomGenerator.makeColor())
        delegate?.didRandomizeColor(model: model)
    }
    
    func changeAlpha(on model : Model, with alpha: Alpha?){
        if let newAlpha = alpha {
            model.updateAlpha(newAlpha)
            delegate?.didChangeAlpha(model: model)
        }
    }
    
//    func getSelectedModel() -> Drawable? {
//        for model in models {
//            if model.selectedStatus() {return model}
//        }
//        return nil
//    }
    
}
