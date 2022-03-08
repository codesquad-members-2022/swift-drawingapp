//
//  ViewController.swift
//  DrawingApp
//
//  Created by Selina on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {
    
    let x = UIScreen.main.bounds.width
    let y = UIScreen.main.bounds.height
    let button = UIButton(type: .system) as UIButton
    let factory = RectangleFactory()
    var plane = Plane()


    @objc func createRectangleButtonTapped(_ sender: UIButton) {
        let rectangle = factory.createRectangle()
        plane.addRectangle(rectangle)
    }
    
    
    func createRectangleButton() {
        self.button.frame = CGRect(x: x - 250, y: y - 150, width: 150, height: 75)
        self.button.backgroundColor = UIColor.systemCyan
        self.button.setTitle("사각형 생성", for: .normal)
        self.button.tintColor = .white
        self.button.addTarget(self, action: #selector(createRectangleButtonTapped(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRectangleButton()
    }
}
