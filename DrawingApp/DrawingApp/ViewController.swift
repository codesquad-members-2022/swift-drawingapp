//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김한솔 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    let plane = Plane()
    var rectangleFactory: RectangleFactory?
    weak var generateRectangleButton: UIButton!
    weak var drawableAreaView: UIView!
    @IBOutlet weak var statusView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGenerateRectangleButton()
        addDrawableAreaView()
        
        let drawableAreaSize = (width: Double(self.drawableAreaView.frame.width),
                                height: Double(self.drawableAreaView.frame.height))
        
        let rectangleFactory = RectangleFactory(screenSize: drawableAreaSize)
        self.rectangleFactory = rectangleFactory
        rectangleFactory.delegate = self
        
    }
    
    func addGenerateRectangleButton() {
        let buttonUIAction = UIAction { _ in
            let _ = self.rectangleFactory?.generateRandomRectangle()
        }
        let generateButton = UIButton(type: .custom, primaryAction: buttonUIAction)
        let buttonWidth = 100.0
        let buttonHeight = 100.0
        let buttonX = (self.view.frame.size.width/2.0) - (buttonWidth/2.0)
        let buttonY = self.view.frame.size.height - buttonHeight
        generateButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
        generateButton.backgroundColor = .gray
        generateButton.setTitle("사각형 생성", for: .normal)
        
        self.generateRectangleButton = generateButton
        self.view.addSubview(generateButton)
    }
    
    func addDrawableAreaView() {
        let drawableViewX = self.view.frame.origin.x
        let drawableViewY = self.view.frame.origin.y
        let drawableViewWidth = self.view.frame.width - self.statusView.frame.width
        let generateButtonHeight = 100.0
        let drawableViewHeight = self.view.frame.height - generateButtonHeight
        let drawableAreaView = UIView(frame: CGRect(x: drawableViewX, y: drawableViewY, width: drawableViewWidth, height: drawableViewHeight))
        drawableAreaView.clipsToBounds = true
        
        self.drawableAreaView = drawableAreaView
        self.view.addSubview(drawableAreaView)
    }

}

extension ViewController: RectangleDelegate {
    func factoryDidGenerateRandomRectangle(_ rectangle: Rectangle) {
        os_log("\(rectangle)")
        plane.add(rectangle: rectangle)
        
        let newRectangleView = ViewFactory.generateRectangleView(of: rectangle)
        self.drawableAreaView.addSubview(newRectangleView)
    }
}
