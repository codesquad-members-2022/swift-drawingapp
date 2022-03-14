//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

protocol PlaneDelegate {
    func getScreenSize() -> Size
}

protocol PlaneModelFactoryBase {
    func make(modelType: DrawingModel.Type, _ data: [Any]) -> DrawingModel
}

protocol PlaneChanged {
    func change(alpha: Alpha)
    func change(color: Color)
    func change(fontName: String)
    func transform(translationX: Double, y: Double)
    func transform(width: Double, height: Double)
}

protocol PlaneGusture {
    func tapGusturePoint(_ point: Point)
    func beganDragPoint(_ point: Point)
    func changedDragPoint(_ point: Point)
    func endedDragPoint(_ point: Point)
}

protocol PlaneAction {
    func selecteModel(index: Int)
    func move(to type: Plane.MoveTo)
}

protocol PlaneMakeModel {
    func makeModel(modelType: DrawingModel.Type, url: URL?)
}

class Plane {
    var delegate: PlaneDelegate?
    
    private var drawingModels: [DrawingModel] = []
    private var selectedModel: DrawingModel?
    private var modelFactory: PlaneModelFactoryBase?
    
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
        
        NotificationCenter.default.post(name: Plane.Event.didDeselecteDrawingModel, object: self, userInfo: [ParamKey.drawingModel: model, ParamKey.index: index])
    }
    
    private func sendDidSelectModel(_ model: DrawingModel) {
        guard let index = drawingModels.firstIndex(of: model) else {
            return
        }
        NotificationCenter.default.post(name: Plane.Event.didSelecteDrawingModel, object: self, userInfo: [ParamKey.drawingModel:model, ParamKey.index: index])
    }
    
    private func calibrateScreenInOrigin(to point: Point, size: Size) -> Point? {
        guard let screenSize = self.delegate?.getScreenSize() else {
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

extension Plane: PlaneMakeModel {
    func makeModel(modelType: DrawingModel.Type, url: URL? = nil) {
        guard let model = self.modelFactory?.make(modelType: modelType, [url]) else {
            return
        }
        self.drawingModels.insert(model, at: 0)
        NotificationCenter.default.post(name: Plane.Event.didMakeDrawingModel, object: self, userInfo: [ParamKey.drawingModel:model])
    }
}

extension Plane: PlaneChanged {
    func change(alpha: Alpha) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(alpha: alpha)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: self.selectedModel,
            ParamKey.alpha: alpha
        ]
        NotificationCenter.default.post(name: Event.didUpdateAlpha, object: self, userInfo: userInfo)
    }
    
    func change(color: Color) {
        guard let model = self.selectedModel as? Colorable else {
            return
        }
        model.update(color: color)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: self.selectedModel,
            ParamKey.color: color
        ]
        NotificationCenter.default.post(name: Event.didUpdateColor, object: self, userInfo: userInfo)
    }
    
    func change(fontName: String) {
        guard let labelModel = self.selectedModel as? LabelModel else {
            return
        }
        let font = Font(name: fontName, size: labelModel.font.size)
        labelModel.update(font: font)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: self.selectedModel,
            ParamKey.font: font
        ]
        NotificationCenter.default.post(name: Event.didUpdateFont, object: self, userInfo: userInfo)
    }
    
    func transform(translationX: Double, y: Double) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(x: translationX, y: y)
        
        let userInfo: [AnyHashable : Any] = [
            ParamKey.drawingModel: self.selectedModel,
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
            ParamKey.drawingModel: self.selectedModel,
            ParamKey.size: model.size
        ]
        NotificationCenter.default.post(name: Event.didUpdateSize, object: self, userInfo: userInfo)
    }
}

extension Plane: PlaneGusture {
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
    func move(to move: MoveTo) {
        guard let selectModel = self.selectedModel,
        let targetIndex = self.drawingModels.firstIndex(of: selectModel) else {
            return
        }
        self.drawingModels.remove(at: targetIndex)
        
        var moveIndex = 0

        switch move {
        case .front:
            moveIndex = 0
        case .forward:
            moveIndex = targetIndex == 0 ? 0 : targetIndex - 1
        case .last:
            moveIndex = self.drawingModels.count
        case .back:
            moveIndex = targetIndex >= self.drawingModels.count - 1 ? self.drawingModels.count - 1 : targetIndex + 1
        }
        let moveViewIndex = self.drawingModels.count - moveIndex
        self.drawingModels.insert(selectModel, at: moveIndex)
        
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
        static let didDeselecteDrawingModel = NSNotification.Name("didDeselecteDrawingModel")
        static let didSelecteDrawingModel = NSNotification.Name("didSelecteDrawingModel")
        static let didMakeDrawingModel = NSNotification.Name("didMakeDrawingModel")
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
        static let didUpdateFontColor = NSNotification.Name("didUpdateFontColor")
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
    
    enum MoveTo {
        case front, forward, last, back
    }
}
