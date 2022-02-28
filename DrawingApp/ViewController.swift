//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    private var rectangles = RectangleArray()
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
    }

    @IBAction func makeRandomRectangle(_ sender: Any) {
        rectangles.makeRectangle(viewWidth: self.view.frame.width, viewHeight: self.view.frame.height)
        
        guard let rectangle = rectangles.nowMadeRectangle() else{
            let alert = UIAlertController(title: "Warning", message: "작성된 사각형이 없습니다.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel)
            alert.addAction(okayAction)
            self.present(alert, animated: true)
            return
        }
        
        let rectangleView = UIView(frame: CGRect(x: rectangle.showPoint()[0], y: rectangle.showPoint()[1], width: rectangle.showSize()[0], height: rectangle.showSize()[1]))
        rectangleView.backgroundColor = UIColor(displayP3Red: rectangle.showColor()[0], green: rectangle.showColor()[1], blue: rectangle.showColor()[2], alpha: rectangle.showAlpha())
        rectangleView.restorationIdentifier = rectangle.showId()
        
        self.view.addSubview(rectangleView)
    }
    
}

