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
            
            if rectangleViews[selected] != selectedRectangleView {
                selectedRectangleView?.layer.borderWidth = 0
            }
            selectedRectangleView = rectangleViews[selected]
            selectedRectangleView?.layer.borderWidth = 5
            plane.selectedRectangle = selected
            
        } else {
            selectedRectangleView?.layer.borderWidth = 0
        }
    }
}

// Delegate : Model
extension ViewController: PlaneDelegate {
 

    func RectangleDidAdd(_ rectangle: Rectangle) {
        let rect = UIView(frame: CGRect(x: rectangle.position.x, y: rectangle.position.y, width: rectangle.size.width, height: rectangle.size.height))
        rect.backgroundColor = Convertor.convertColor(from: rectangle.backgroundColor)
        rect.alpha = Double(rectangle.alpha.rawValue) * 0.1
        self.canvasView.addSubview(rect)
        rect.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        rect.isUserInteractionEnabled = false
        
        rectangleViews[rectangle] = rect
        
    }
    
}


extension ViewController: ControllerViewDelegate {
    
    func backgroundButtonDidTouch() {
        let changedColor = Color.randomColor()
        selectedRectangleView?.backgroundColor = Convertor.convertColor(from: changedColor)
        plane.changeBackgroundColor(to: changedColor)
        
        // 모델에게 해당 Rect의 색이 변경되었음을 알려주기
        plane.selectedRectangle?.changedBackGroundColor(to: Convertor.convertColor(from: selectedRectangleView?.backgroundColor ?? UIColor()))
    }
}
