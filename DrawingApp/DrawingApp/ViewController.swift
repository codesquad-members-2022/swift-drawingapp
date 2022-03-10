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
        let logger = Logger()
        let newRectangle = Factory.createRectangle()
        logger.info("\(newRectangle)")
        
        let test = UIView.init(frame: CGRect(x: newRectangle.point.x, y: newRectangle.point.y, width: newRectangle.size.width, height: newRectangle.size.height))
        test.backgroundColor = UIColor.red
//        test.backgroundColor = UIColor(red: 0, green: CGFloat(newRectangle.color.g), blue: CGFloat(newRectangle.color.b), alpha: newRectangle.alpha.self)
        self.view.addSubview(test)


    }
    
}

