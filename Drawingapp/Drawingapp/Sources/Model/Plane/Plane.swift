//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

protocol PlaneAction {
    var delegate: PlaneDelegate? {get set}
    func touchPoint(_ point: Point)
    func changeAlpha(_ alpha: Alpha)
    func changeColor()
    func changeFont(name: String)
    func transform(translationX: Double, y: Double)
    func transform(width: Double, height: Double)
    func beganDrag(point: Point)
    func changedDrag(point: Point)
    func endedDrag(point: Point)
    func selecteModel(_ model: DrawingModel)
    func deselecteModel(_ model: DrawingModel)
}

protocol PlaneDelegate {
    func injectDrawingModelFactory() -> DrawingModelFactory
    func injectScreenSize() -> Size
}

protocol MakeModelAction {
    func makeRectangleModel(origin: Point)
    func makePhotoModel(origin: Point, url: URL)
    func makeLabelModel(origin: Point)
}

class Plane {
    var delegate: PlaneDelegate?
    
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
    
    private func calibrateScreenInOrigin(to point: Point, size: Size) -> Point? {
        guard let screenSize = self.delegate?.injectScreenSize() else {
            return nil
        }
        
        var originX = point.x - size.width / 2
        originX = originX < 1 ? 1 : originX
        originX = originX + size.width > screenSize.width ? screenSize.width - size.width : originX
        
        var originY = point.y - size.height / 2
        originY = originY < 1 ? 1 : originY
        originY = originY + size.height > screenSize.height ? screenSize.height - size.height : originY
        
        return Point(x: originX, y: originY)
    }
}

extension Plane: MakeModelAction {
    func makeRectangleModel(origin: Point) {
        guard let model = self.delegate?.injectDrawingModelFactory().makeRectangleModel(origin: origin) else {
            return
        }
        didMakeDrawingModel(model: model)
    }
    
    func makePhotoModel(origin: Point, url: URL) {
        guard let model = self.delegate?.injectDrawingModelFactory().makePhotoModel(origin: origin, url: url) else {
            return
        }
        didMakeDrawingModel(model: model)
    }
    
    func makeLabelModel(origin: Point) {
        guard let model = self.delegate?.injectDrawingModelFactory().makeLabelModel(origin: origin) else {
            return
        }
        didMakeDrawingModel(model: model)
    }
    
    private func didMakeDrawingModel(model: DrawingModel) {
        self.drawingModels.append(model)
        NotificationCenter.default.post(name: Plane.Event.didMakeDrawingModel, object: self, userInfo: [ParamKey.drawingModel:model])
        
    }
}

extension Plane: PlaneAction {
    private func sendDidDeselectModel(_ model: DrawingModel?) {
        guard let model = model else {
            return
        }
        NotificationCenter.default.post(name: Plane.Event.didDeselecteDrawingModel, object: self, userInfo: [ParamKey.drawingModel:model])
    }
    
    private func sendDidSelectModel(_ model: DrawingModel) {
        NotificationCenter.default.post(name: Plane.Event.didSelecteDrawingModel, object: self, userInfo: [ParamKey.drawingModel:model])
    }
    
    func selecteModel(_ model: DrawingModel) {
        guard let prevSelectModel = self.selectedModel else {
            sendDidSelectModel(model)
            self.selectedModel = model
            return
        }
        
        if model != prevSelectModel {
            sendDidDeselectModel(prevSelectModel)
            sendDidSelectModel(model)
            self.selectedModel = model
        }
    }
    
    func deselecteModel(_ model: DrawingModel) {
        
    }
    
    func touchPoint(_ point: Point) {
        guard let selectModel = self.selected(point: point) else {
            sendDidDeselectModel(self.selectedModel)
            self.selectedModel = nil
            return
        }
        
        guard let prevSelectModel = self.selectedModel else {
            sendDidSelectModel(selectModel)
            self.selectedModel = selectModel
            return
        }
        
        if selectModel != prevSelectModel {
            sendDidDeselectModel(prevSelectModel)
            sendDidSelectModel(selectModel)
            self.selectedModel = selectModel
        }
    }
    
    func beganDrag(point: Point) {
        self.touchPoint(point)
        guard let dragModel = self.selectedModel else {
            return
        }
        NotificationCenter.default.post(name: Plane.Event.didBeganDrag, object: self, userInfo: [ParamKey.drawingModel:dragModel])
    }
    
    func changedDrag(point: Point) {
        guard let dragModel = self.selectedModel,
              let newOrigin = self.calibrateScreenInOrigin(to: point, size: dragModel.size) else {
            return
        }
        
        NotificationCenter.default.post(name: Plane.Event.didChangedDrag, object: self, userInfo: [ParamKey.dragPoint:Point(x: newOrigin.x, y: newOrigin.y)])
    }
    
    func endedDrag(point: Point) {
        guard let dragModel = self.selectedModel,
              let newOrigin = self.calibrateScreenInOrigin(to: point, size: dragModel.size) else {
            return
        }
        dragModel.update(origin: Point(x: newOrigin.x, y: newOrigin.y))
        NotificationCenter.default.post(name: Plane.Event.didEndedDrag, object: self, userInfo: nil)
    }
    
    func transform(translationX: Double, y: Double) {
        guard let model = self.selectedModel else {
            return
        }
        model.originMove(x: translationX, y: y)
    }
    
    func updateSize(_ size: Size) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(size: size)
    }
    
    func transform(width: Double, height: Double) {
        guard let model = self.selectedModel else {
            return
        }
        model.sizeIncrease(width: width, height: height)
    }
    
    func changeColor() {
        guard let model = self.selectedModel as? Colorable else {
            return
        }
        model.update(color: Color(using: RandomColorGenerator()))
    }
    
    func changeAlpha(_ alpha: Alpha) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(alpha: alpha)
    }
    
    func changeFont(name: String) {
        guard let labelModel = self.selectedModel as? LabelModel else {
            return
        }
        labelModel.update(font: Font(name: name, size: labelModel.font.size))
    }
}

extension Plane {
    enum Event {
        static let didDeselecteDrawingModel = NSNotification.Name("didDeselecteDrawingModel")
        static let didSelecteDrawingModel = NSNotification.Name("didSelecteDrawingModel")
        static let didMakeDrawingModel = NSNotification.Name("didMakeDrawingModel")
        static let didBeganDrag = NSNotification.Name("didBeganDrag")
        static let didChangedDrag = NSNotification.Name("didChangedDrag")
        static let didEndedDrag = NSNotification.Name("didEndedDrag")
    }
    
    enum ParamKey {
        static let drawingModel = "drawingModel"
        static let dragPoint = "dragPoint"
    }
}
