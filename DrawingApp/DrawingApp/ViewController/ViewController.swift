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
            // 선택된게 있을때
            plane.setSelectedRectangle(selected) // 모델에 추가 -> 델리게이트
            selectedRectangleView = rectangleViews[selected]
            
            
            // 다른 사각형을 선택했을때, 이전 사각형 테두리 지워주기
//            if rectangleViews[selected] != selectedRectangleView {
//                selectedRectangleView?.layer.borderWidth = 0
//            }
            
            // 선택한 사각형에 대한 속성을 컨트롤러 뷰에 표현, 테두리 표시
//            selectedRectangleView = rectangleViews[selected]
//            controllerView.alphaSlider.setValue(Float(selectedRectangleView?.alpha ?? 1.0) * 10 , animated: true)
//            controllerView.backgroundButton.setTitle(selectedRectangleView?.backgroundColor?.convertHex(), for: .normal)
//            selectedRectangleView?.layer.borderWidth = 5
//            selectedRectangleView?.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
            
            
            // 선택된 사각형이 없는 경우 이전 사각형 border 지우기
        } else {
            clear()

        }
    }
}

// Delegate : Model
extension ViewController: PlaneDelegate {
    
    func rectangleDidMutate(_ selected: Rectangle) {
        selectedRectangleView?.layer.borderWidth = 0 // 이전 사각형테두리 지우기
        selectedRectangleView = rectangleViews[selected]
        selectedRectangleView?.layer.borderWidth = 5
        
//        selectedRectangleView?.backgroundColor?.withAlphaComponent(selectedRectangleView!.alpha)
        
        
        
        
    }
    

    func RectangleDidAdd(_ rectangle: Rectangle) {
        let rect = UIView(frame: CGRect(x: rectangle.position.x, y: rectangle.position.y, width: rectangle.size.width, height: rectangle.size.height))
//        let alpha = Double(rectangle.alpha.rawValue) * 0.1
        let color = Convertor.convertColor(from: rectangle.backgroundColor, alpha: rectangle.alpha)
        rect.backgroundColor = color
        
        self.canvasView.addSubview(rect)
        rect.isUserInteractionEnabled = false
        
        rectangleViews[rectangle] = rect
    }
    
    func BackgroundDidChanged(_ rectangle: Rectangle) {
        let hexString = Convertor.colorToHexString(rectangle.backgroundColor)
        controllerView.backgroundButton.setTitle(hexString, for: .normal)

        let newColor = Convertor.convertColor(from: rectangle.backgroundColor, alpha: rectangle.alpha)
        selectedRectangleView?.backgroundColor = newColor
   
    }
    
    func alpahDidChanged(_ rectangle: Rectangle) {
        let alpha = rectangle.alpha
        controllerView.alphaSlider.setValue(Float(alpha.rawValue), animated: true)
        let newAlpha = Convertor.convertColor(from: rectangle.backgroundColor, alpha: rectangle.alpha)
        selectedRectangleView?.backgroundColor = newAlpha
    }
    
}


extension ViewController: ControllerViewDelegate {
    
    func backgroundButtonDidTouch() {
        let changedColor = Color.randomColor()
        plane.changeBackgroundColor(to: changedColor)
        
    }
    
    func alphaSliderDidChange(_ value: Float) {
//        selectedRectangleView?.alpha = CGFloat(value) / 10.0
        plane.changeAlpha(value: Int(value))
        
    }
}


