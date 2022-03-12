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
    func didAppendRectangleModel(model: Rectangle?)
    func didSearchForRectangleModel(detectedModels: [Rectangle])
    func didRandomizeColor(model : Rectangle)
    func didChangeAlpha(model: Rectangle)
}

struct Plane{
    
    var delegate : PlaneDelegate?
    private var rectangles = [Rectangle]()
    var numberOfRect : Int {
        self.rectangles.count
    }
    subscript(index: Int) -> Rectangle?{
        get {
            guard numberOfRect > index , -1 > index else {return nil}
            return rectangles[index]
        }
    }
    
    mutating func append(_ rect : Rectangle) {
        self.rectangles.append(rect)
        os_log(.debug, "Plane 에 새로 들어온 사각형 정보 : \(rect) ")
        delegate?.didAppendRectangleModel(model: rectangles.last)
    }
    
    
    
    func searchRectangleModel(tabCoordX x : Double, tabCoordY y: Double)  {

        let detectedModels = rectangles.filter{
            let minX = $0.point.x
            let minY = $0.point.y
            let maxX = $0.point.x + $0.size.width
            let maxY = $0.point.y + $0.size.height
            
            if (minX <= x && maxX >= x && minY <= y && maxY >= y) || $0.selectedStatus(){
                $0.toggleSelected()
                return true
            }
              return false
        }
        delegate?.didSearchForRectangleModel(detectedModels:detectedModels)
    }
    
    func randomizeColor(on model: Rectangle){
        model.updateColor(RandomGenerator.makeColor())
        delegate?.didRandomizeColor(model: model)
    }
    
    func changeAlpha(on model : Rectangle, with alpha: Alpha?){
        if let newAlpha = alpha {
            model.updateAlpha(newAlpha)
            delegate?.didChangeAlpha(model: model)
        }
    }
    
    func getSelectedModel() -> Rectangle? {
        for model in rectangles {
            if model.selectedStatus() {return model}
        }
        return nil
    }
    
}
