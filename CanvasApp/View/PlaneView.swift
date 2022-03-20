//
//  PlaneView.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/18.
//

import UIKit

protocol DrawingDelegate : NSObject {
    func planeBeganDrawing(_ planeView : PlaneView)
    func planeEndedDrawing(_ planeView : PlaneView, points: [CGPoint])
}

class PlaneView: UIView {
    private var points = [CGPoint]()
    private var isDrawingMode = false
    weak var delegate : DrawingDelegate? = nil

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard isDrawingMode, points.count > 0 else { return }
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: points.first!)
        for point in points {
            context?.addLine(to: point)
        }
        context?.setStrokeColor(UIColor.gray.cgColor)
        context?.setLineWidth(3)
        context?.strokePath()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard isDrawingMode, let point = touches.first?.location(in: self) else { return }
        points.append(point)
        delegate?.planeBeganDrawing(self)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard isDrawingMode, let point = touches.first?.location(in: self) else { return }
        points.append(point)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard isDrawingMode, let point = touches.first?.location(in: self) else { return }
        points.append(point)
        delegate?.planeEndedDrawing(self, points: points)
        setNeedsDisplay()
    }
    
    func toggleDrawingMode() {
        isDrawingMode.toggle()
        points.removeAll()
        setNeedsDisplay()
    }
    
    func deselectAll() {
        for subview in self.subviews {
            subview.layer.borderWidth = 0
        }
    }
}
