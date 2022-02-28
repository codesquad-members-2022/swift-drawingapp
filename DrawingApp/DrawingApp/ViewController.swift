//
//  ViewController.swift
//  DrawingApp
//
//  Created by dale on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = (Double(self.view.safeAreaLayoutGuide.layoutFrame.size.width), Double(self.view.safeAreaLayoutGuide.layoutFrame.size.height))
        let rect1 = RectangleFactory(screenSize: screenSize).make()
        let rect2 = RectangleFactory(screenSize: screenSize).make()
        let rect3 = RectangleFactory(screenSize: screenSize).make()
        let rect4 = RectangleFactory(screenSize: screenSize).make()
        
    }


}

