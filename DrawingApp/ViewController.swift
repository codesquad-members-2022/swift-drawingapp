//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class ViewController: UIViewController {
    private var rectangles = RectangleArray()
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
    }

    @IBAction func makeRandomRectangle(_ sender: Any) {
        rectangles.makeRectangle(viewWidth: self.view.frame.width, viewHeight: self.rectangleButton.frame.minY)
        
        guard let rectangle = rectangles.nowMadeRectangle() else{
            let alert = UIAlertController(title: "Warning", message: "작성된 사각형이 없습니다.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
            alert.addAction(okayAction)
            self.present(alert, animated: true)
            return
        }
        
        let rectangleView = UIView(frame: CGRect(x: rectangle.showPoint().xValue(), y: rectangle.showPoint().yValue(), width: rectangle.showSize().widthValue(), height: rectangle.showSize().heightValue()))
        rectangleView.backgroundColor = UIColor(displayP3Red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
        rectangleView.restorationIdentifier = rectangle.showId()
        
        os_log("%@", "\(rectangle.description)")
        self.view.addSubview(rectangleView)
    }
    
}

