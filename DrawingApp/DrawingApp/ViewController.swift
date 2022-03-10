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
        
        let util = Util(color: newRectangle.color, alpha: newRectangle.alpha)
        test.backgroundColor = util.getUIColor()
        self.view.addSubview(test)

    }
    
}

