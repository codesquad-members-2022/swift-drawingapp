//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    var plane = Plane()
    var selectedView: UIView? = nil
    let shapeFactory = ShapeFactory()
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    @IBOutlet weak var alphaValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap Gesture Recognizer 초기화
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        
        // Tap Gesture Recognizer를 뷰 전체에 추가
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        let touchedCGPoint = sender.location(in: self.view)
        let touchedPoint = Point(x: touchedCGPoint.x, y: touchedCGPoint.y)
        let touchedView = self.view.hitTest(touchedCGPoint, with: nil)
        
        var touchedViewRed: CGFloat = 0
        var touchedViewGreen: CGFloat = 0
        var touchedViewBlue: CGFloat = 0
        var touchedViewAlpha: CGFloat = 0
        touchedView?.backgroundColor?.getRed(&touchedViewRed, green: &touchedViewGreen, blue: &touchedViewBlue, alpha: &touchedViewAlpha)
        
        let isRectangleAtPoint = plane.isThereARectangle(point: touchedPoint)
        if isRectangleAtPoint, selectedView == nil {
            selectedView = touchedView
            touchedView?.layer.borderWidth = 5
            touchedView?.layer.borderColor = UIColor.blue.cgColor
            redValue.text = "R : \(touchedViewRed)"
            greenValue.text = "G : \(touchedViewGreen)"
            blueValue.text = "B : \(touchedViewBlue)"
            alphaValue.text = "A : \(touchedViewAlpha)"
        }
        if isRectangleAtPoint, selectedView != nil {
            selectedView?.layer.borderWidth = 0
            selectedView = touchedView
            touchedView?.layer.borderWidth = 5
            touchedView?.layer.borderColor = UIColor.blue.cgColor
            redValue.text = "R : \(touchedViewRed)"
            greenValue.text = "G : \(touchedViewGreen)"
            blueValue.text = "B : \(touchedViewBlue)"
            alphaValue.text = "A : \(touchedViewAlpha)"
        }
        if !isRectangleAtPoint {
            selectedView?.layer.borderWidth = 0
            selectedView = nil
            redValue.text = "-"
            alphaValue.text = "-"
        }
    }
    
    @IBAction func drawRectangle(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        let randomX = Int.random(in: 1...Int(bounds.width))
        let randomY = Int.random(in: 1...Int(bounds.height))
        let randomCGRed = CGFloat(Double.random(in: 0...255) / 255)
        let randomCGGreen = CGFloat(Double.random(in: 0...255) / 255)
        let randomCGBlue = CGFloat(Double.random(in: 0...255) / 255)
        let randomCGAlpha = CGFloat(Double.random(in: 1...10) / 10)
        let rectangleView = UIView(frame: CGRect(x: randomX, y: randomY, width: 150, height: 120))
        rectangleView.backgroundColor = UIColor(red: randomCGRed, green: randomCGGreen, blue: randomCGBlue, alpha: randomCGAlpha)
        self.view.addSubview(rectangleView)
        
        let randomColor = Color(r: Int(randomCGRed * 255), g: Int(randomCGGreen * 255), b: Int(randomCGBlue * 255))
        let randomAlpha: Alpha = Alpha(rawValue: Int(randomCGAlpha * 10))!
        let rectangle = shapeFactory.createRectangle(
            point: Point(x: Double(randomX), y: Double(randomY)),
            size: Size(width: 150, height: 120),
            color: randomColor, alpha: randomAlpha)
        plane.addRectangle(rectangle)
    }
    
    @IBAction func resetRGB(_ sender: Any) {
    }
    
    @IBAction func tapAlphaStepper(_ sender: Any) {
    }
}

