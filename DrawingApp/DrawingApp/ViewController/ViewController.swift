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
}

// Delegate : Model
extension ViewController: PlaneDelegate {
    
    func addRectangle(_ rectangle: Rectangle) {
        let rect = UIView(frame: CGRect(x: rectangle.position.x, y: rectangle.position.y, width: rectangle.size.width, height: rectangle.size.height))
    
        rect.backgroundColor = UIColor(red: CGFloat(rectangle.backgroundColor.red)/255, green: CGFloat(rectangle.backgroundColor.green)/255, blue: CGFloat(rectangle.backgroundColor.blue)/255, alpha: 1)
        rect.alpha = Double(rectangle.alpha.rawValue) * 0.1
        print(rect)
        self.view.addSubview(rect)
        
    }
    
    
    
}

