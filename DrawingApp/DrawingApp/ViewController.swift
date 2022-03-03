//
//  ViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    let factory = FactoryViewRandomProperty()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factory.delegate = self
    }
    
    @IBAction func buttonForAddTouchUpInside(_ sender: UIButton) {
        Logger(subsystem: OSLog.subsystem, category: "Screen control check").debug("buttonForAddTouchUpInside(_:UIButton)")
    }
    
    @IBAction func buttonAdmitColorTouchUpInside(_ sender: UIButton) {
        Logger(subsystem: OSLog.subsystem, category: "Screen control check").debug("buttonAdmitColorTouchUpInside(_:UIButton)")
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        sender.value = round(sender.value)
        Logger(subsystem: OSLog.subsystem, category: "Screen control check").debug("sliderAdmitAlphaValueChanged(_:UISlider)")
    }
    
    @IBAction func sliderAdmitAlphaEditingChanged(_ sender: UISlider) {
        // Do Not Execute...
        Logger(subsystem: OSLog.subsystem, category: "Screen control check").debug("sliderAdmitAlphaEditingChanged(_:UISlider)")
    }
}

extension ViewController: MasterViewDelegate {
    func getMasterViewProperty() -> FactoryProperties {
        let frame = self.view.frame
        
        return FactoryProperties(
            maxX: frame.maxX,
            maxY: frame.maxY,
            width: frame.width,
            height: frame.height
        )
    }
}

extension CGRect {
    static func useViewModel(point: RectPoint, size: RectSize) -> CGRect {
        CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
    }
}

extension UIColor {
    static func useViewModel(rgbValue: RectRGBColor, alpha: Double) -> UIColor {
        UIColor(red: rgbValue.r/255, green: rgbValue.g/255, blue: rgbValue.b/255, alpha: alpha/10)
    }
}
