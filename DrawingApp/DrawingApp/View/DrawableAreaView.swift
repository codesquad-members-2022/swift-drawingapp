//
//  DrawableAreaView.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/03/18.
//

import UIKit

protocol DrawableAreaViewDelegate: AnyObject {
    func drawableAreaViewDidReceiveTap(_ drawableAreaView: DrawableAreaView)
    func drawableAreaViewDidBeginPan(_ drawableAreaView: DrawableAreaView)
    func drawableAreaViewDidChangePan(_ drawableAreaView: DrawableAreaView)
    func drawableAreaViewDidEndPan(_ drawableAreaView: DrawableAreaView)
}

class DrawableAreaView: UIView {
    
    weak var delegate: DrawableAreaViewDelegate?
    private(set) var touchedPoint: Point?
    private(set) var selectedView: RectangleViewable?
    private(set) var movingTemporaryView: RectangleViewable?
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        addGestures()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.clipsToBounds = true
        addGestures()
    }
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        self.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        panGesture.minimumNumberOfTouches = 2
        panGesture.maximumNumberOfTouches = 2
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        let touchedLocation = sender.location(in: self)
        self.touchedPoint = Point(x: touchedLocation.x, y: touchedLocation.y)
        
        delegate?.drawableAreaViewDidReceiveTap(self)
    }
    
    @objc private func panAction(_ sender: UIPanGestureRecognizer) {
        let tanslation = sender.translation(in: self)
        
        switch sender.state {
            case .began:
                let touchedLocation = sender.location(in: self)
                self.touchedPoint = Point(x: touchedLocation.x, y: touchedLocation.y)
                
                delegate?.drawableAreaViewDidBeginPan(self)
                
            case .changed:
                guard let movingTemporaryView = movingTemporaryView else {return}
                movingTemporaryView.move(distance: tanslation)
                sender.setTranslation(.zero, in: self)
                
                delegate?.drawableAreaViewDidChangePan(self)
                
            case .ended:
                guard let movingTemporaryView = movingTemporaryView else {return}
               
                delegate?.drawableAreaViewDidEndPan(self)
                movingTemporaryView.removeFromSuperview()
                self.movingTemporaryView = nil
            default: return
        }
    }
    
    func makeTemporaryView() {
        guard let selectedView = selectedView,
              let copiedView = selectedView.copy() as? RectangleViewable else {return}
        
        copiedView.changeAlphaValue(to: 0.5)
        self.movingTemporaryView = copiedView
        
        addSubview(copiedView)
    }
    
    func add(subView: UIView & RectangleViewable) {
        self.addSubview(subView)
    }
    
    func showSelectedView(_ selectedView: RectangleViewable?) {
        self.selectedView?.hideBoundary()
        
        self.selectedView = selectedView
        selectedView?.showBoundary()
    }
    
    func updateSelectedView(backgroundColor: UIColor) {
        guard let selectedView = selectedView as? ViewBackgroundColorChangable else {
            return
        }
        
        selectedView.changeBackgroundColor(to: backgroundColor)
    }
    
    func updateSelectedView(alpha: CGFloat) {
        self.selectedView?.changeAlphaValue(to: alpha)
    }
    
    func updateSelectedView(point: CGPoint) {
        self.selectedView?.move(to: point)
    }
    
    func updateSelectedView(width: CGFloat, height: CGFloat) {
        self.selectedView?.resize(to: (width, height))
    }
    
}
