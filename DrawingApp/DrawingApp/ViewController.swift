//
//  ViewController.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createRectangle(_ sender: UIButton) {
        let factory = FactoryArray()
        factory.createRectangle()
        print(factory.createRectanleArray())
    }
    
}

