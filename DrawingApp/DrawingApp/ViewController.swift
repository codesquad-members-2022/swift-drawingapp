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
    var factory: RectangleFactory?
    weak var generateRectangleButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGenerateRectangleButton()
        
        let currentScreenSize = (width: Double(self.view.safeAreaLayoutGuide.layoutFrame.width),
                                 height: Double(self.view.safeAreaLayoutGuide.layoutFrame.height))
        let factory = RectangleFactory(screenSize: currentScreenSize)
        self.factory = factory
        factory.delegate = self
        let rect1 = factory.generateRandomRectangle()
        let rect2 = factory.generateRandomRectangle()
        let rect3 = factory.generateRandomRectangle()
        let rect4 = factory.generateRandomRectangle()
    func addGenerateRectangleButton() {
        let buttonWidth = 100.0
        let buttonHeight = 100.0
        let buttonX = self.view.safeAreaLayoutGuide.layoutFrame.width/2.0 - buttonWidth/2.0
        let buttonY = self.view.safeAreaLayoutGuide.layoutFrame.height - buttonHeight
        let generateButton = UIButton.init(frame: CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight))
        generateButton.backgroundColor = .gray
        generateButton.isEnabled = true
        generateButton.setTitle("사각형 생성", for: .normal)
        
        self.generateRectangleButton = generateButton
        self.view.addSubview(generateButton)
    }
    }


}

extension ViewController: RectangleDelegate {
    func factoryDidGenerateRandomRectangle(_ rectangle: Rectangle) {
        os_log("\(rectangle)")
        plane.add(rectangle: rectangle)
    }
}
