//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    var plane = Plane()
    var selectedShape: Shape? = nil
    let shapeFactory = ShapeFactory()
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    @IBOutlet weak var rgbValue: UILabel!
    
    @IBOutlet weak var alphaValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tap Gesture Recognizer 초기화
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        
        // Tap Gesture Recognizer를 뷰 전체에 추가
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        print("didTapView", sender)
        let touchCGPoint = sender.location(in: self.view)
        let touchPoint = Point(x: touchCGPoint.x, y: touchCGPoint.y)
        print(plane.isThereARectangle(point: touchPoint))
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

