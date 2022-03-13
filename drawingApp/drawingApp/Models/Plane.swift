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
    func didSearchForModel(detectedModel: Model?)
    func didRandomizeColor(model : Model)
    func didChangeAlpha(model: Model)
}

class Plane{
    
    var delegate : PlaneDelegate?
    private var models = [Model]()
    private let size: Size
    private let point: Point
    private var selectedModel : Model?
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
    
    
    
    
    func searchForModel(tabCoordX x : Double, tabCoordY y: Double) {
        
        let reversedArray = self.models.reversed()
        var detectedModel : Model?
        for model in reversedArray {
            let minX = model.point.x
            let minY = model.point.y
            let maxX = model.point.x + model.size.width
            let maxY = model.point.y + model.size.height
            
            if (minX <= x && maxX >= x && minY <= y && maxY >= y){
                detectedModel = model
            }
        }
        delegate?.didSearchForModel(detectedModel: detectedModel)
        
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
