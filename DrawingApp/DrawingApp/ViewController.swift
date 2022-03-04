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

protocol RectangleViewValueChangeDelegate {
    func setColor()
    func setAlpha(as value: CGFloat)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var setRandomColorButton: UIButton!
    @IBOutlet weak var setAlphaSlider: UISlider!
    
    private var currentSelected: Rectangle?
    
    let factory = FactoryViewRandomProperty()
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
            let current = currentSelected,
            let property = plane.getRectangleProperty(at: current.index)
        else {
            return
        }
        
        let color = property.resetRGBColor()
        setRandomColorButton.backgroundColor = UIColor(
            red: color.r/255,
            green: color.g/255,
            blue: color.b/255,
            alpha: property.getAlpha()
        )
        currentSelected?.setBackgroundColor(using: property)
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        
        guard let currentSelected = currentSelected else {
            return
        }
        
        sender.value = round(sender.value)
        plane.setProperty(at: currentSelected.index, alpha: sender.value)
        currentSelected.setValue(alpha: sender.value)
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
    func setSelected(_ view: Rectangle) {
        currentSelected?.isSelected = false
        
        guard let property = plane.getRectangleProperty(at: view.index) else {
            return
        }
        
        setRandomColorButton.backgroundColor = view.backgroundColor
        setAlphaSlider.setValue(Float(round(property.getAlpha())), animated: true)
        
        view.isSelected = true
        currentSelected = view
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        if touch.view == currentSelected {
            return false
        }
        
        currentSelected?.isSelected = false
        currentSelected = nil
        
        setRandomColorButton.backgroundColor = UIColor.systemFill
        setAlphaSlider.setValue(0, animated: true)
        
        return true
    }
}

// MARK: - UIKit extension types

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
