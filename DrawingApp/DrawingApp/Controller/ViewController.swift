//
//  ViewController.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var addButton: UIButton!
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
        let borderColor = UIColor(named: "Border")
        
        self.addButton.tintColor = fontColor
        self.addButton.setBorder(width: 1, radius: 10, color: borderColor)
        self.addButton.addTarget(self, action: #selector(self.onPressToAddRectangle), for: .touchUpInside)
        
        self.colorButton.tintColor = fontColor
        self.colorButton.setBorder(width: 1, radius: 10, color: borderColor)
        self.colorButton.addTarget(self, action: #selector(self.onPressToChangeColor), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    @objc func onPressToAddRectangle(_ sender: UIButton) {
        let rectangle = RectangleFactory.makeRandomRectangle()
        plane.append(item: rectangle)
        
        let rectangleView = UIView(frame: .zero)
        rectangleView.frame.origin = rectangle.origin.convert(using: CGPoint.self)
        rectangleView.frame.size = rectangle.size.convert(using: CGSize.self)
        rectangleView.backgroundColor = .orange
        
        let touchRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapRectangle))
        rectangleView.addGestureRecognizer(touchRecognizer)
        
        self.planeView.addSubview(rectangleView)
    }
    
    @objc func onPressToChangeColor(_ sender: UIButton) {}
    
    @objc func tapRectangle(_ sender: UITapGestureRecognizer) {
        print("Tab")
    }
}
