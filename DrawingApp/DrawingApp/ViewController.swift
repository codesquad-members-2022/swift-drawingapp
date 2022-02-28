//
//  ViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
//    var subviews = [UIView]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addRectButtonTouchUpInside(_ sender: UIButton) {
        let subviewName = "subView #\(self.view.subviews.count)"
        let viewModel = FactoryViewRandomProperty.make(as: subviewName, in: self.view)
        
        let randomView = UIView(frame: CGRect.viewModelRect(point: viewModel.point, size: viewModel.size))
        randomView.backgroundColor = UIColor.viewModelColor(value: viewModel.rgbValue, alpha: viewModel.alpha)
        
        self.view.addSubview(randomView)
        
        print(viewModel)
    }
}

extension CGRect {
    static func viewModelRect(point: RectPoint, size: RectSize) -> CGRect {
        CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
    }
}

extension UIColor {
    static func viewModelColor(value: RectRGBColor, alpha: Double) -> UIColor {
        UIColor(red: value.r/255, green: value.g/255, blue: value.b/255, alpha: alpha)
    }
}
