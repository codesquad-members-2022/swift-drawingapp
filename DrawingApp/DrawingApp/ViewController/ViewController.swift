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
    var selectedRectangleView: UIView?
    var rectangleViews = [Rectangle : UIView]()
    
    @IBOutlet var canvasView: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plane.delegate = self
        canvasView.delgate = self
    }

}
// Delegate : View
extension ViewController: RectangleViewDelegate {
    
    func touchedAddRectangleButton() {
        plane.add(rectangle: factory.createRandomRectangle())
    }
    
    func touchedCanvas(at point: CGPoint) {
        let touchedPoint = Point(x: point.x, y: point.y)
        if let selected = plane.ExistRectangle(at: touchedPoint) {
            
            if rectangleViews[selected] != selectedRectangleView {
                selectedRectangleView?.layer.borderWidth = 0
            }
            
            selectedRectangleView = rectangleViews[selected]
            selectedRectangleView?.layer.borderWidth = 5
            
        } else {
            selectedRectangleView?.layer.borderWidth = 0
        }
    }
}

// Delegate : Model
extension ViewController: PlaneDelegate {
    func selectedRectangle(_ rectangle: Rectangle) {
    }

    func addRectangle(_ rectangle: Rectangle) {
        let rect = UIView(frame: CGRect(x: rectangle.position.x, y: rectangle.position.y, width: rectangle.size.width, height: rectangle.size.height))
    
        rect.backgroundColor = UIColor(red: CGFloat(rectangle.backgroundColor.red)/255, green: CGFloat(rectangle.backgroundColor.green)/255, blue: CGFloat(rectangle.backgroundColor.blue)/255, alpha: 1)
        rect.alpha = Double(rectangle.alpha.rawValue) * 0.1
        self.canvasView.addSubview(rect)
        rect.layer.borderColor = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
        rect.isUserInteractionEnabled = false
        
        rectangleViews[rectangle] = rect
        
    }
    
    
    
}

