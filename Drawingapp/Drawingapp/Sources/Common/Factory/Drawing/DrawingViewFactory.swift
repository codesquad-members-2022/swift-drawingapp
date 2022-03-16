//
//  DrawingFactory.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/02.
//

import Foundation

class DrawingViewFactory: DrawingViewFactoryBase {
    
    private let modelToViewType: Dictionary<ObjectIdentifier, DrawingView.Type> = [
        ObjectIdentifier(DrawingModel.self): DrawingView.self,
        ObjectIdentifier(RectangleModel.self): RectangleView.self,
        ObjectIdentifier(PhotoModel.self): PhotoView.self,
        ObjectIdentifier(LabelModel.self): LabelView.self
    ]
    
    func make(drawingable: Drawingable) -> DrawingView {
        if let viewType = self.modelToViewType[ObjectIdentifier(type(of: drawingable.self))] {
            return viewType.init(drawingable: drawingable)
        }
        return DrawingView.init(drawingable: drawingable)
    }
}
