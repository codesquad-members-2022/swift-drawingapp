//
//  ViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var buttonSetRandomColor: UIButton!
    @IBOutlet weak var sliderSetAlpha: UISlider!
    
    let factory = FactoryRectangleProperty()
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factory.delegate = self
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        screenView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func buttonForAddTouchUpInside(_ sender: UIButton) {
        if let property = factory.makeRandomView(as: "subview #\(screenView.subviews.count)") {
            plane.addProperties(property)
            
            let rectangle = Rectangle(model: property)
            rectangle.delegate = self
            rectangle.index = plane.getRectangleCount()-1
            
            screenView.addSubview(rectangle)
        }
    }
    
    @IBAction func buttonAdmitColorTouchUpInside(_ sender: UIButton) {
        guard
            let index = plane.current?.index,
            let property = plane.getRectangleProperty(at: index),
            let color = property.resetRGBColor()
        else {
            return
        }
        
        buttonSetRandomColor.backgroundColor = UIColor(
            red: color.r/255,
            green: color.g/255,
            blue: color.b/255,
            alpha: property.alpha
        )
        
        plane.current?.setBackgroundColor(using: property)
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        
        guard let index = plane.current?.index else { return }
        
        sender.value = round(sender.value)
        plane.setProperty(at: index, alpha: sender.value)
        buttonSetRandomColor.backgroundColor = buttonSetRandomColor.backgroundColor?.withAlphaComponent(CGFloat(sender.value/10))
        plane.current?.setValue(alpha: sender.value)
    }
}

// MARK: - Custom Protocol Delegate Pattern

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
    func changeCurrentSelected(_ rectangle: Rectangle) {
        plane.current?.isSelected = false
        
        guard let property = plane.getRectangleProperty(at: rectangle.index) else {
            return
        }
        
        buttonSetRandomColor.backgroundColor = rectangle.backgroundColor
        sliderSetAlpha.setValue(Float(round(property.alpha)), animated: true)
        
        rectangle.isSelected = true
        plane.current = rectangle
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        if touch.view == plane.current {
            return false
        }
        
        plane.current?.isSelected = false
        plane.current = nil
        
        buttonSetRandomColor.backgroundColor = UIColor.systemFill
        sliderSetAlpha.setValue(0, animated: true)
        
        return true
    }
}

// MARK: - UIKit extension types

extension CGRect {
    static func useViewModel(point: RectOrigin, size: RectSize) -> CGRect {
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
