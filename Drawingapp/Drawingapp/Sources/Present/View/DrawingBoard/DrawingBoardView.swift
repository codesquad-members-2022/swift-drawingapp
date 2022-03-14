//
//  DrawingViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/14.
//

import Foundation
import UIKit

class DrawingBoardView: UIView {
    private var drawingViews: [DrawingModel:DrawingView] = [:]
    private var dummyView: UIView?
    
    func didMakeDrawingModel(model: DrawingModel) {
        let drawView = DrawingViewFactory.make(model: model)
        self.addSubview(drawView)
        self.drawingViews[model] = drawView
    }
    
    func select(model: DrawingModel) {
        drawingViews[model]?.selected(is: true)
    }
    
    func deselect(model: DrawingModel) {
        drawingViews[model]?.selected(is: false)
    }
    
    func didBeganDrag(model: DrawingModel) {
        guard let selectView = drawingViews[model],
              let snapshotView = selectView.snapshotView() else {
                  return
              }
        self.addSubview(snapshotView)
        snapshotView.alpha = 0.5
        snapshotView.isHidden = true
        self.dummyView = snapshotView
    }
    
    func didChangedDrag(point: Point) {
        guard let dummyView = self.dummyView else {
                  return
              }
        dummyView.isHidden = false
        dummyView.frame.origin = CGPoint(x: point.x, y: point.y)
    }
    
    func didEndedDrag() {
        self.dummyView?.removeFromSuperview()
        self.dummyView = nil
    }
    
    func didChangeSubviewIndex(target: DrawingModel, index: Int) {
        guard let targetView = drawingViews[target] else {
            return
        }
        self.insertSubview(targetView, at: index)
    }
    
    func didUpdate(model: DrawingModel, alpha: Alpha) {
        self.drawingViews[model]?.update(alpha: alpha)
    }
    
    func didUpdate(model: DrawingModel, origin: Point) {
        self.drawingViews[model]?.update(origin: origin)
    }
    
    func didUpdate(model: DrawingModel, size: Size) {
        self.drawingViews[model]?.update(size: size)
    }
    
    func didUpdate(model: DrawingModel, color: Color) {
        guard let colableView = self.drawingViews[model] as? Colorable else {
            return
        }
        
        colableView.update(color: color)
    }
    
    func didUpdate(model: DrawingModel, font: Font) {
        guard let textable = self.drawingViews[model] as? Textable else {
            return
        }
        textable.update(font: font)
    }
}
