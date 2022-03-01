//
//  ViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addRectButtonTouchUpInside(_ sender: UIButton) {
        let subviewName = "subView #\(view.subviews.count)"
        let viewModel = FactoryViewRandomProperty(name: subviewName, superview: view).make()
        
        let randomView = UIView(frame: CGRect.useViewModel(point: viewModel.point, size: viewModel.size))
        randomView.backgroundColor = UIColor.useViewModel(rgbValue: viewModel.rgbValue, alpha: viewModel.alpha)
        
        view.addSubview(randomView)
        
        Log.error(String(describing: viewModel))
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
