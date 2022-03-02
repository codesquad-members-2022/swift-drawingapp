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
        
        for i in 1...4 {
            
            guard let viewModel = factory.makeRandomView(as: "subView #\(i)") else {
                continue
            }
            
            let randomView = UIView(frame: CGRect.useViewModel(point: viewModel.point, size: viewModel.size))
            randomView.backgroundColor = UIColor.useViewModel(rgbValue: viewModel.rgbValue, alpha: viewModel.alpha)
            
            Log.error(String(describing: viewModel))
        }
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
