//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

protocol PlaneDataSource {
    func getScreenSize() -> Size
}

protocol PlaneModelFactoryBase {
    func make(modelType: DrawingModel.Type, counting: Int, _ data: [Any]) -> DrawingModel
}

protocol PlaneAction {
    func selecteModel(index: Int)
    func move(to index: Int)
}

class Plane {
    private var drawingModels: [DrawingModel] = []
    private var selectedModel: DrawingModel?
    private var modelFactory: PlaneModelFactoryBase?
    
    var dataSource: PlaneDataSource? {
        didSet {
            screenSize = dataSource?.getScreenSize()
        }
    }
    
    private var screenSize: Size?
    
    private var modelCounting: [ObjectIdentifier:Int] = [
        ObjectIdentifier(RectangleModel.self): 0,
        ObjectIdentifier(PhotoModel.self): 0,
        ObjectIdentifier(LabelModel.self): 0
    ]
    
    var count: Int {
        drawingModels.count
    }
    
    var selectIndex: Int? {
        guard let model = self.selectedModel,
              let index = drawingModels.firstIndex(of: model) else {
            return nil
        }
        return index
    }
    
    subscript(index: Int) -> DrawingModel? {
        if index >= 0 && index <= drawingModels.count {
            return drawingModels[index]
        }
        return nil
    }
    
    init(modelFactory: PlaneModelFactoryBase) {
        self.modelFactory = modelFactory
    }
    
    private func selected(point: Point) -> DrawingModel? {
        for model in drawingModels {
            if model.isSelected(by: point) {
                return model
            }
        }
        return nil
    }
    
    private func sendDidDeselectModel(_ model: DrawingModel?) {
        guard let model = model,
              let index = drawingModels.firstIndex(of: model) else {
            return
        }
        
        NotificationCenter.default.post(name: Plane.Event.didDeselecteModel, object: self, userInfo: [ParamKey.drawingModel: model, ParamKey.index: index])
    }
    
    private func sendDidSelectModel(_ model: DrawingModel) {
        guard let index = drawingModels.firstIndex(of: model) else {
            return
        }
        NotificationCenter.default.post(name: Plane.Event.didSelecteModel, object: self, userInfo: [ParamKey.drawingModel:model, ParamKey.index: index])
    }
    
    private func calibrateScreenInOrigin(to point: Point, size: Size) -> Point? {
        guard let screenSize = self.screenSize else {
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

extension Plane: Makeable {
    func makeModel(type modelType: DrawingModel.Type, data: [Any] = []) {
        
        let counting = (modelCounting[ObjectIdentifier(modelType)] ?? 0) + 1
        modelCounting[ObjectIdentifier(modelType)] = counting
        
        guard let model = self.modelFactory?.make(modelType: modelType, counting: counting, data) else {
            return
        }
        self.drawingModels.insert(model, at: 0)
        NotificationCenter.default.post(name: Plane.Event.didMakeModel, object: self, userInfo: [ParamKey.drawingModel:model])
    }
}

extension Plane: AlphaUpdatable, ColorUpdatable, FontUpdatable, Transformable {
    func update(alpha: Alpha) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(alpha: alpha)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: model,
            ParamKey.alpha: alpha
        ]
        NotificationCenter.default.post(name: Event.didUpdateAlpha, object: self, userInfo: userInfo)
    }
    
    func update(color: Color) {
        guard let model = self.selectedModel as? Colorable else {
            return
        }
        model.update(color: color)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: model,
            ParamKey.color: color
        ]
        NotificationCenter.default.post(name: Event.didUpdateColor, object: self, userInfo: userInfo)
    }
    
    func update(fontName: String) {
        guard let labelModel = self.selectedModel as? LabelModel else {
            return
        }
        labelModel.update(fontName: fontName)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: labelModel,
            ParamKey.font: labelModel.font
        ]
        NotificationCenter.default.post(name: Event.didUpdateFont, object: self, userInfo: userInfo)
    }
    
    func transform(translationX: Double, y: Double) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(x: translationX, y: y)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: model,
            ParamKey.origin: model.origin
        ]
        NotificationCenter.default.post(name: Event.didUpdateOrigin, object: self, userInfo: userInfo)
    }
    
    func transform(width: Double, height: Double) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(width: width, height: height)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: model,
            ParamKey.size: model.size
        ]
        NotificationCenter.default.post(name: Event.didUpdateSize, object: self, userInfo: userInfo)
    }
}

extension Plane: GusturePoint {
    func tapGusturePoint(_ point: Point) {
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
    
    func beganDragPoint(_ point: Point) {
        self.tapGusturePoint(point)
        guard let dragModel = self.selectedModel else {
            return
        }
        NotificationCenter.default.post(name: Plane.Event.didBeganDrag, object: self, userInfo: [ParamKey.drawingModel:dragModel])
    }
    
    func changedDragPoint(_ point: Point) {
        guard let dragModel = self.selectedModel,
              let newOrigin = self.calibrateScreenInOrigin(to: point, size: dragModel.size) else {
            return
        }
        NotificationCenter.default.post(name: Plane.Event.didChangedDrag, object: self, userInfo: [ParamKey.dragPoint:Point(x: newOrigin.x, y: newOrigin.y)])
    }
    
    func endedDragPoint(_ point: Point) {
        guard let dragModel = self.selectedModel,
              let newOrigin = self.calibrateScreenInOrigin(to: point, size: dragModel.size) else {
            return
        }
        let origin = Point(x: newOrigin.x, y: newOrigin.y)
        dragModel.update(origin: origin)
        NotificationCenter.default.post(name: Plane.Event.didEndedDrag, object: self, userInfo: nil)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: dragModel,
            ParamKey.origin: origin
        ]
        NotificationCenter.default.post(name: Event.didUpdateOrigin, object: self, userInfo: userInfo)
    }
}

extension Plane: PlaneAction {
    func move(to index: Int) {
        guard let selectModel = self.selectedModel,
        let targetIndex = self.drawingModels.firstIndex(of: selectModel),
        targetIndex != index else {
            return
        }
        
        self.drawingModels.remove(at: targetIndex)
        self.drawingModels.insert(selectModel, at: index)
        
        let moveViewIndex = self.drawingModels.count - 1 - index
        
        NotificationCenter.default.post(name: Plane.Event.didMoveModel, object: self, userInfo: [ParamKey.drawingModel:selectModel, ParamKey.index: moveViewIndex])
    }
    
    func selecteModel(index: Int) {
        let selectModel = self.drawingModels[index]
        
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
}

extension Plane {
    enum Event {
        static let didDeselecteModel = NSNotification.Name("didDeselecteModel")
        static let didSelecteModel = NSNotification.Name("didSelecteModel")
        static let didMakeModel = NSNotification.Name("didMakeModel")
        static let didBeganDrag = NSNotification.Name("didBeganDrag")
        static let didChangedDrag = NSNotification.Name("didChangedDrag")
        static let didEndedDrag = NSNotification.Name("didEndedDrag")
        static let didMoveModel = NSNotification.Name("didMoveModel")
        
        static let didUpdateColor = NSNotification.Name("didUpdateColor")
        static let didUpdateOrigin = NSNotification.Name("didUpdateOrigin")
        static let didUpdateSize = NSNotification.Name("didUpdateSize")
        static let didUpdateAlpha = NSNotification.Name("didUpdateAlpha")
        static let didUpdateImageUrl = NSNotification.Name("didUpdateImageUrl")
        static let didUpdateText = NSNotification.Name("didUpdateText")
        static let didUpdateFont = NSNotification.Name("didUpdateFont")
    }
    
    enum ParamKey {
        static let drawingModel = "drawingModel"
        static let dragPoint = "dragPoint"
        static let index = "index"
        static let id = "id"
        static let alpha = "alpha"
        static let origin = "origin"
        static let size = "size"
        static let color = "color"
        static let imageUrl = "imageUrl"
        static let text = "text"
        static let font = "font"
        static let fontColor = "fontColor"
    }
}
