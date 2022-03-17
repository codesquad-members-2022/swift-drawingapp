//
//  ViewController.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/02.
//

import UIKit
import os

class ViewController: UIViewController {

    var plane = Plane()
    let factory = RectangleFactory()
    private var selectedRectangleView: UIView?
    var rectangleViews = [Rectangle : UIView]()

    var controllerView: ControllerView!
    var canvasView: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureSubscriber()
    }
    
    func configureLayout() {
        controllerView = Bundle.main.loadNibNamed("ControllerView", owner: self, options: nil)?.first as? ControllerView
        canvasView = Bundle.main.loadNibNamed("CanvasView", owner: self, options: nil)?.first as? CanvasView
        
        self.view.addSubview(canvasView)
        self.view.addSubview(controllerView)
        
        controllerView.translatesAutoresizingMaskIntoConstraints = false
        controllerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        controllerView.widthAnchor.constraint(equalToConstant: 197).isActive = true
        controllerView.heightAnchor.constraint(equalToConstant: 820).isActive = true

        controllerView.delegate = self
        canvasView.delgate = self
    }
    
    func configureSubscriber() {
        NotificationCenter.default.addObserver(self, selector: #selector(rectangleDidMutate(_:)), name: .rectangleDidMutate, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(RectangleDidAdd(_:)), name: .rectangleDidAdd, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(BackgroundDidChanged(_:)), name: .backgroundDidChagned, object: plane)
        NotificationCenter.default.addObserver(self, selector: #selector(alpahDidChanged(_:)), name: .alpahDidChanged, object: plane)
    }
    
    func clear() {
        selectedRectangleView?.layer.borderWidth = 0
        selectedRectangleView = nil
        plane.selectedRectangle = nil
        controllerView.alphaSlider.setValue(0.0, animated: true)
        controllerView.backgroundButton.setTitle("None", for: .normal)
    }

}
// Delegate : View
extension ViewController: RectangleViewDelegate {
   
    func addRectangleButtonDidTouch() {
        plane.add(rectangle: factory.createRandomRectangle())
    }
    
    func canvasDidTab(at point: CGPoint) {
        let touchedPoint = Point(x: point.x, y: point.y)
        if let selected = plane.ExistRectangle(at: touchedPoint) {
            plane.setSelectedRectangle(selected)
            selectedRectangleView = rectangleViews[selected]
        } else {
            clear()  // 선택된 사각형이 없는 경우
        }
    }
}

// Delegate : Model
extension ViewController {
    
    @objc func rectangleDidMutate(_ notification: NSNotification) {
        guard let selected = notification.userInfo?["updateRectangle"] as? Rectangle else { return }
        selectedRectangleView?.layer.borderWidth = 0 // 이전 사각형테두리 지우기
        selectedRectangleView = rectangleViews[selected]
        selectedRectangleView?.layer.borderWidth = 5
    }
    
    @objc
    func RectangleDidAdd(_ notification: NSNotification) {
        guard let newRectangle = notification.userInfo?["updateRectangle"] as? Rectangle else { return }
        let rect = UIView(frame: CGRect(x: newRectangle.position.x, y: newRectangle.position.y, width: newRectangle.size.width, height: newRectangle.size.height))
        let color = Convertor.convertColor(from: newRectangle.backgroundColor, alpha: newRectangle.alpha)
        rect.backgroundColor = color
        self.canvasView.addSubview(rect)
        rect.isUserInteractionEnabled = false
        rectangleViews[newRectangle] = rect
    }
    
    @objc
    func BackgroundDidChanged(_ notification: NSNotification) {
        guard let selected = notification.userInfo?["updateRectangle"] as? Rectangle else { return }
        
        let hexString = Convertor.colorToHexString(selected.backgroundColor)
        controllerView.backgroundButton.setTitle(hexString, for: .normal)

        let newColor = Convertor.convertColor(from: selected.backgroundColor, alpha: selected.alpha)
        selectedRectangleView?.backgroundColor = newColor
   
    }
    
    @objc
    func alpahDidChanged(_ notification: NSNotification) {
        guard let selected = notification.userInfo?["updateRectangle"] as? Rectangle else { return }
        
        let alpha = selected.alpha
        controllerView.alphaSlider.setValue(Float(alpha.rawValue), animated: true)
        let newAlpha = Convertor.convertColor(from: selected.backgroundColor, alpha: selected.alpha)
        selectedRectangleView?.backgroundColor = newAlpha
    }
    
}


extension ViewController: ControllerViewDelegate {
    
    func backgroundButtonDidTouch() {
        let changedColor = Color.randomColor()
        plane.changeBackgroundColor(to: changedColor)
    }
    
    func alphaSliderDidChange(_ value: Float) {
        plane.changeAlpha(value: Int(value))
    }
}


