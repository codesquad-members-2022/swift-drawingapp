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
        let factory = FactoryArray()
        
        logger.info("\(factory.createRectanleArray())")
    }
    
}

