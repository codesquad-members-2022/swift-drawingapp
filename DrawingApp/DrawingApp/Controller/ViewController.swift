//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var planeView: UIView!
    
    private var plane = Plane()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureButtons()
    }
    
    func configureButtons() {
        let fontColor = UIColor(named: "Font")
        let boderColor = UIColor(named: "Border")
        
        self.addButton.layer.cornerRadius = 10
        self.addButton.layer.borderWidth = 1
        self.addButton.layer.cornerCurve = .continuous
        self.addButton.layer.borderColor = boderColor?.cgColor
        self.addButton.tintColor = fontColor
        self.addButton.addTarget(self, action: #selector(self.onPressToAddRectangle), for: .touchUpInside)
        
        self.colorButton.layer.cornerRadius = 10
        self.colorButton.layer.borderWidth = 1
        self.colorButton.layer.cornerCurve = .continuous
        self.colorButton.layer.borderColor = boderColor?.cgColor
        self.colorButton.tintColor = fontColor
        self.colorButton.addTarget(self, action: #selector(self.onPressToChangeColor), for: .touchUpInside)
    }
    
    @objc
    func onPressToAddRectangle(_ sender: UIButton) {
        let rectangle = RectangleFactory.makeRandomRectangle()
        plane.append(item: rectangle)
        
        let rectangleView = UIView(frame: .zero)
        rectangleView.frame.origin = CGPoint(x: rectangle.origin.x, y: rectangle.origin.y)
        rectangleView.frame.size.width = CGFloat(rectangle.size.width)
        rectangleView.frame.size.height = CGFloat(rectangle.size.height)
        rectangleView.backgroundColor = .orange
        
        self.planeView.addSubview(rectangleView)
        
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapRectangle))
        rectangleView.addGestureRecognizer(touchRecognizer)
    }
    
    @objc
    func onPressToChangeColor(_ sender: UIButton) {}
    
    @objc
    func tapRectangle(_ sender: UITapGestureRecognizer) {
        print("Tab")
    }
}
