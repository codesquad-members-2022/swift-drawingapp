//
//  DrawingViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/14.
//

import Foundation
import UIKit

protocol DrawingBoardDelegate {
    func tapGusturePoint(_ point: Point)
    func beganDragPoint(_ point: Point)
    func changedDragPoint(_ point: Point)
    func endedDragPoint(_ point: Point)
}

class DrawingBoardView: UIView {
    var delegate: DrawingBoardDelegate?
    
    private var drawingViewFactory: DrawingViewFactoryBase = DrawingViewFactory()
    private var drawingViews: [DrawingModel:DrawingView] = [:]
    private var dummyView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    private func bind() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGusture))
        self.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGusture))
        self.addGestureRecognizer(panGesture)
        
    }
    
    @objc private func tapGusture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        self.delegate?.tapGusturePoint(Point(x: location.x, y: location.y))
    }
    
    @objc private func panGusture(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        let point = Point(x: location.x, y: location.y)
        switch sender.state {
        case .began:
            self.delegate?.beganDragPoint(point)
        case .changed:
            self.delegate?.changedDragPoint(point)
        case .ended:
            self.delegate?.endedDragPoint(point)
        default:
            break
        }
    }
    
    func didMakeDrawingModel(model: DrawingModel) {
        let drawView = drawingViewFactory.make(drawingable: model)
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
        guard let colableView = self.drawingViews[model] as? ColorUpdatable else {
            return
        }
        
        colableView.update(color: color)
    }
    
    func didUpdate(model: DrawingModel, font: Font) {
        guard let labelView = self.drawingViews[model] as? FontUpdatable else {
            return
        }
        labelView.update(font: font)
    }
}
