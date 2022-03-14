//
//  ViewController.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createRectangle(_ sender: UIButton) {
        let newRectangle = Factory.createRectangle()
    
        OSLog.log(message: newRectangle.description)
        
        let test = UIView.init(frame: CGRect(x: newRectangle.point.x, y: newRectangle.point.y, width: newRectangle.size.width, height: newRectangle.size.height))
        
        let check = Convert.toUIColor(color: newRectangle.color, alpha: newRectangle.alpha)
        
        test.backgroundColor = check
        print(check.toHex() ?? "")
        
        
        
        self.view.addSubview(test)

    }
    
}

