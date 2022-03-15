//
//  ViewController.swift
//  DrawingApp
//
//  Created by Bibi on 2022/03/04.
//

import UIKit

class ViewController: UIViewController {
    
    var plane = Plane()
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
        print(randomX, randomY)
        let rectangle = shapeFactory.createRandomRectangle(point: Point(x: Double(randomX), y: Double(randomY)))
        let rectangleView = UIView(frame: CGRect(x: randomX, y: randomY, width: 150, height: 120))
        rectangleView.backgroundColor = .blue
        self.view.addSubview(rectangleView)
        plane.addRectangle(rectangle)
    }
    
    @IBAction func resetRGB(_ sender: Any) {
    }
    
    @IBAction func tapAlphaStepper(_ sender: Any) {
    }
}

