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
    func changeColor(_ color: Color)
    func changeAlpha(_ alpha: Alpha)
}

protocol MakeModelAction {
    func makeDrawingModel()
    func makeDrawingModel(url: URL)
}

class Plane {
    private let drawingModelFactory: DrawingModelFactory
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
    
    init(drawingModelFactory: DrawingModelFactory) {
        self.drawingModelFactory = drawingModelFactory
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
        let model = drawingModelFactory.makeModel()
        didMakeDrawingModel(model: model)
    }
    
    func makeDrawingModel(url: URL) {
        let model = drawingModelFactory.makeModel(url: url)
        didMakeDrawingModel(model: model)
    }
    
    private func didMakeDrawingModel(model: DrawingModel) {
        self.drawingModels.append(model)
        let userInfo: [AnyHashable : Any] = [ParamKey.drawingModel:model]
        NotificationCenter.default.post(name: Plane.NotifiName.didMakeDrawingModel, object: self, userInfo: userInfo)
        
    }
}

extension Plane: PlaneAction {
    
    private func sendDidDisSelectModel(_ model: DrawingModel?) {
        guard let model = model else {
            return
        }
        let userInfo: [AnyHashable : Any] = [ParamKey.drawingModel:model]
        NotificationCenter.default.post(name: Plane.NotifiName.didDisSelectedDrawingModel, object: self, userInfo: userInfo)
    }
    
    private func sendDidSelectModel(_ model: DrawingModel) {
        let userInfo: [AnyHashable : Any] = [ParamKey.drawingModel:model]
        NotificationCenter.default.post(name: Plane.NotifiName.didSelectedDrawingModel, object: self, userInfo: userInfo)
    }
    
    func touchPoint(where point: Point) {
        guard let selectModel = self.selected(point: point) else {
            sendDidDisSelectModel(self.selectedModel)
            self.selectedModel = nil
            return
        }
        
        guard let prevSelectModel = self.selectedModel else {
            sendDidSelectModel(selectModel)
            self.selectedModel = selectModel
            return
        }
        
        if selectModel != prevSelectModel {
            sendDidDisSelectModel(prevSelectModel)
            sendDidSelectModel(selectModel)
            self.selectedModel = selectModel
        }
    }
    
    func changeColor(_ color: Color) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(color: color)
    }
    
    func changeAlpha(_ alpha: Alpha) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(alpha: alpha)
    }
    
}

extension Plane {
    enum NotifiName {
        static let didDisSelectedDrawingModel = NSNotification.Name("didDisSelectedDrawingModel")
        static let didSelectedDrawingModel = NSNotification.Name("didSelectedDrawingModel")
        static let didMakeDrawingModel = NSNotification.Name("didMakeDrawingModel")
    }
    
    enum ParamKey {
        static let drawingModel = "drawingModel"
    }
}
