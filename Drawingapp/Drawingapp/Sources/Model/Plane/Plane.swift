//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

protocol PlaneAction {
    func touchPoint(where point: Point)
    func colorChanged(_ color: Color)
    func alphaChanged(_ alpha: Alpha)
}

protocol MakeModelAction {
    func makeDrawingModel()
    func makeDrawingModel(url: URL)
}

class Plane {    
    private var drawingModels: [DrawingModel] = []
    private var selectedModel: DrawingModel?
    
    var count: Int {
        drawingModels.count
    }
    
    subscript(index: Int) -> DrawingModel? {
        if index >= 0 && index <= drawingModels.count {
            return drawingModels[index]
        }
        return nil
    }
    
    private func selected(point: Point) -> DrawingModel? {
        let models = drawingModels.reversed()
        for model in models {
            if model.isSelected(by: point) {
                return model
            }
        }
        return nil
    }
}

extension Plane: MakeModelAction {
    func makeDrawingModel() {
        let model = DrawingModelFactory.makeModel()
        didMakeDrawingModel(model: model)
    }
    
    func makeDrawingModel(url: URL) {
        let model = DrawingModelFactory.makeModel(url: url)
        didMakeDrawingModel(model: model)
    }
    
    private func didMakeDrawingModel(model: DrawingModel) {
        self.drawingModels.append(model)
        let userInfo: [AnyHashable : Any] = [ParamKey.drawingModel:model]
        NotificationCenter.default.post(name: Plane.EventName.didMakeDrawingModel, object: nil, userInfo: userInfo)
        
    }
}

extension Plane: PlaneAction {
    func touchPoint(where point: Point) {
        if let model = self.selectedModel {
            self.selectedModel = nil
            let userInfo: [AnyHashable : Any] = [ParamKey.drawingModel:model]
            NotificationCenter.default.post(name: Plane.EventName.didDisSelectedDrawingModel, object: self, userInfo: userInfo)
        }
        
        if let model = self.selected(point: point) {
            self.selectedModel = model
            let userInfo: [AnyHashable : Any] = [ParamKey.drawingModel:model]
            NotificationCenter.default.post(name: Plane.EventName.didSelectedDrawingModel, object: self, userInfo: userInfo)
        }
    }
    
    func colorChanged(_ color: Color) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(color: color)
    }
    
    func alphaChanged(_ alpha: Alpha) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(alpha: alpha)
    }
    
}

extension Plane {
    enum EventName {
        static let didDisSelectedDrawingModel = NSNotification.Name("didDisSelectedDrawingModel")
        static let didSelectedDrawingModel = NSNotification.Name("didSelectedDrawingModel")
        static let didMakeDrawingModel = NSNotification.Name("didMakeDrawingModel")
    }
    
    enum ParamKey {
        static let drawingModel = "drawingModel"
    }
}
