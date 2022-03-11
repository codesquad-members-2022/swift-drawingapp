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
    func originChanged(_ origin: Point)
    func originMoved(x: Double, y: Double)
    func sizeChanged(_ size: Size)
    func sizeIncrease(width: Double, height: Double)
    func alphaChanged(_ alpha: Alpha)
    func colorChanged()
    func onPanGustureAction(state: UIGestureRecognizer.State, point: Point)
}

protocol PlaneDelegate {
    func getDrawingModelFactory() -> DrawingModelFactory
}

protocol MakeModelAction {
    func makeRectangleModel(origin: Point)
    func makePhotoModel(origin: Point, url: URL)
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
            guard let dragModel = self.selectedModel else {
                return
            }
            let originX = point.x - dragModel.size.width / 2
            let originY = point.y - dragModel.size.height / 2
            let userInfo: [AnyHashable : Any] = [ParamKey.dragPoint:Point(x: originX, y: originY)]
            NotificationCenter.default.post(name: Plane.NotifiName.didChangedDrag, object: self, userInfo: userInfo)
        case .ended:
            guard let dragModel = self.selectedModel else {
                return
            }
            let originX = point.x - dragModel.size.width / 2
            let originY = point.y - dragModel.size.height / 2
            dragModel.update(origin: Point(x: originX, y: originY))
            NotificationCenter.default.post(name: Plane.NotifiName.didEndedDrag, object: self, userInfo: nil)
        default:
            break
        }
    }
    
    func originChanged(_ origin: Point) {
        guard let model = self.selectedModel else {
            return
        }
        model.update(origin: origin)
    }
    
    func originMoved(x: Double, y: Double) {
        guard let model = self.selectedModel else {
            return
        }
        model.move(x: x, y: y)
    }
    
    func sizeChanged(_ size: Size) {
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
    
    func colorChanged() {
        guard let model = self.selectedModel as? Colorable else {
            return
        }
        model.update(color: Color(using: RandomColorGenerator()))
    }
    
    func alphaChanged(_ alpha: Alpha) {
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
