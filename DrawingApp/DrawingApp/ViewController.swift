//
//  ViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit
import os.log

protocol RectangleViewTapDelegate {
    func setSelected(_ view: Rectangle)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var screenView: UIView!
    
    private var selectedView: Rectangle?
    
    let factory = FactoryViewRandomProperty()
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factory.delegate = self
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.screenView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func buttonForAddTouchUpInside(_ sender: UIButton) {
        if let model = factory.makeRandomView(as: "subview #\(screenView.subviews.count)") {
            plane.addProperties(model)
            let rectangle = Rectangle(randomProperty: model)
            rectangle.delegate = self
            screenView.addSubview(rectangle)
        }
    }
    
    @IBAction func buttonAdmitColorTouchUpInside(_ sender: UIButton) {
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        sender.value = round(sender.value)
    }
    
    @IBAction func sliderAdmitAlphaEditingChanged(_ sender: UISlider) {
        // Do Not Execute...
    }
}

extension ViewController: MasterViewDelegate {
    func getMasterViewProperty() -> FactoryProperties {
        let frame = screenView.frame
        
        return FactoryProperties(
            maxX: frame.maxX,
            maxY: frame.maxY,
            width: frame.width,
            height: frame.height
        )
    }
}

extension ViewController: RectangleViewTapDelegate {
    func setSelected(_ view: Rectangle) {
        selectedView = view
        
        screenView.subviews.forEach {
            ($0 as? Rectangle)?.isSelected = ($0 == selectedView)
        }
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        selectedView?.isSelected = false
        selectedView = nil
        return true
    }
}

extension CGRect {
    static func useViewModel(point: RectPoint, size: RectSize) -> CGRect {
        CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
    }
}

extension UIColor {
    static func useViewModel(rgbValue: RectRGBColor, alpha: Double) -> UIColor {
        UIColor(
            red: rgbValue.r/255,
            green: rgbValue.g/255,
            blue: rgbValue.b/255,
            alpha: alpha/10
        )
    }
}
