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
    
    @IBOutlet var canvasView: CanvasView!
    @IBOutlet var controllerView: ControllerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plane.delegate = self
        canvasView.delgate = self
        controllerView.delegate = self
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
            
            // 다른 사각형을 선택했을때, 이전 사각형 테두리 지워주기
            if rectangleViews[selected] != selectedRectangleView {
                selectedRectangleView?.layer.borderWidth = 0
            }
            
            // 선택한 사각형에 대한 속성을 컨트롤러 뷰에 표현, 테두리 표시
            selectedRectangleView = rectangleViews[selected]
            controllerView.alphaSlider.setValue(Float(selectedRectangleView?.alpha ?? 1.0) * 10 , animated: true)
            controllerView.backgroundButton.setTitle(selectedRectangleView?.backgroundColor?.convertHex(), for: .normal)
            selectedRectangleView?.layer.borderWidth = 5
            selectedRectangleView?.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        } else {
            selectedRectangleView?.layer.borderWidth = 0
        }
    }
}

// Delegate : Model
extension ViewController: PlaneDelegate {

    func RectangleDidAdd(_ rectangle: Rectangle) {
        let rect = UIView(frame: CGRect(x: rectangle.position.x, y: rectangle.position.y, width: rectangle.size.width, height: rectangle.size.height))
//        rect.backgroundColor = Convertor.convertColor(from: rectangle.backgroundColor)
        let alpha = Double(rectangle.alpha.rawValue) * 0.1
        let color = Convertor.convertColor(from: rectangle.backgroundColor, alpha: alpha)
        rect.backgroundColor = color
        
        self.canvasView.addSubview(rect)
        rect.isUserInteractionEnabled = false
        
        rectangleViews[rectangle] = rect
    }
    
    func BackgroundDidChanged() {
        let hexString = selectedRectangleView?.backgroundColor?.convertHex()
        controllerView.backgroundButton.setTitle(hexString, for: .normal)
    }
    
    func alpahDidChanged() {
        if let alpha = selectedRectangleView?.alpha {
            controllerView.alphaSlider.setValue(Float(alpha) * 10, animated: false)
        }
    }
    
}


extension ViewController: ControllerViewDelegate {
    
    func backgroundButtonDidTouch() {
        let changedColor = Color.randomColor()
        guard let selected = selectedRectangleView else { return }
        selected.backgroundColor = Convertor.convertColor(from: changedColor, alpha: selected.alpha)
        plane.changeBackgroundColor(to: changedColor)
        
        // 모델에게 해당 Rect의 색이 변경되었음을 알려주기
        plane.selectedRectangle?.changedBackGroundColor(to: changedColor)
    }
    
    func alphaSliderDidChange(_ value: Float) {
        selectedRectangleView?.alpha = CGFloat(value) / 10.0
        plane.changeAlpha(value: Int(value))
        
    }
}


