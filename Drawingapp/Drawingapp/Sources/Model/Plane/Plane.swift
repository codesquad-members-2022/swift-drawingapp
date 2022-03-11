//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation
import UIKit

protocol PlaneAction {
    func touchPoint(_ point: Point)
    func originChange(_ origin: Point)
    func originMove(x: Double, y: Double)
    func sizeChange(_ size: Size)
    func sizeIncrease(width: Double, height: Double)
    func alphaChange(_ alpha: Alpha)
    func colorChange()
    func onPanGustureAction(state: UIGestureRecognizer.State, point: Point)
}

protocol PlaneDelegate {
    func getDrawingModelFactory() -> DrawingModelFactory
    func getScreenSize() -> Size
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

extension Plane: MakeModelAction {
    func makeRectangleModel(origin: Point) {
        guard let model = self.delegate?.getDrawingModelFactory().makeRectangleModel(origin: origin) else {
            return
        }
        didMakeDrawingModel(model: model)
    }
    
    func makePhotoModel(origin: Point, url: URL) {
        guard let model = self.delegate?.getDrawingModelFactory().makePhotoModel(origin: origin, url: url) else {
            return
        }
        didMakeDrawingModel(model: model)
    }
    
    func makeLabelModel(origin: Point) {
        guard let model = self.delegate?.getDrawingModelFactory().makeLabelModel(origin: origin) else {
            return
        }
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
    
    func touchPoint(_ point: Point) {
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
    
    func onPanGustureAction(state: UIGestureRecognizer.State, point: Point) {
        switch state {
        case .began:
            self.touchPoint(point)
            guard let dragModel = self.selectedModel else {
                return
            }
            let userInfo: [AnyHashable : Any] = [ParamKey.drawingModel:dragModel]
            NotificationCenter.default.post(name: Plane.NotifiName.didBeganDrag, object: self, userInfo: userInfo)
        case .changed:
            guard let dragModel = self.selectedModel,
                  let newOrigin = self.calibrateScreenInOrigin(to: point, size: dragModel.size) else {
                return
            }
            
            let userInfo: [AnyHashable : Any] = [ParamKey.dragPoint:Point(x: newOrigin.x, y: newOrigin.y)]
            NotificationCenter.default.post(name: Plane.NotifiName.didChangedDrag, object: self, userInfo: userInfo)
        case .ended:
            guard let dragModel = self.selectedModel,
                  let newOrigin = self.calibrateScreenInOrigin(to: point, size: dragModel.size) else {
                return
            }
            dragModel.update(origin: Point(x: newOrigin.x, y: newOrigin.y))
            NotificationCenter.default.post(name: Plane.NotifiName.didEndedDrag, object: self, userInfo: nil)
        default:
            break
        }
    }
    
    func originChange(_ origin: Point) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(origin: origin)
    }
    
    func originMove(x: Double, y: Double) {
        guard let model = self.selectedModel else {
            return
        }
        model.originMove(x: x, y: y)
    }
    
    func sizeChange(_ size: Size) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(size: size)
    }
    
    func sizeIncrease(width: Double, height: Double) {
        guard let model = self.selectedModel else {
            return
        }
        model.sizeIncrease(width: width, height: height)
    }
    
    func colorChange() {
        guard let model = self.selectedModel as? Colorable else {
            return
        }
        model.update(color: Color(using: RandomColorGenerator()))
    }
    
    func alphaChange(_ alpha: Alpha) {
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
        static let didBeganDrag = NSNotification.Name("didBeganDrag")
        static let didChangedDrag = NSNotification.Name("didChangedDrag")
        static let didEndedDrag = NSNotification.Name("didEndedDrag")
    }
    
    enum ParamKey {
        static let drawingModel = "drawingModel"
        static let dragPoint = "dragPoint"
    }
}
