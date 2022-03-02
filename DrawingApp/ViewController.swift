//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class ViewController: UIViewController {
    private var rectangles = Plane()
    private let rectangleMaker = RandomRectangleMaker()
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
    }

    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangle = rectangleMaker.makeRectangle(viewWidth: self.view.frame.width, viewHeight: self.rectangleButton.frame.minY)
        self.rectangles.addRectangle(rectangle: rectangle)
        
        let rectangleView = UIView(frame: CGRect(x: rectangle.showPoint().xValue(), y: rectangle.showPoint().yValue(), width: rectangle.showSize().widthValue(), height: rectangle.showSize().heightValue()))
        rectangleView.backgroundColor = UIColor(displayP3Red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
        rectangleView.restorationIdentifier = rectangle.showId()
        
        os_log("%@", "\(rectangle.description)")
        self.view.addSubview(rectangleView)
    }
    
}

