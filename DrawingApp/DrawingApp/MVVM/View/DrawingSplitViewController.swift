//
//  DrawingSplitViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/31.
//

import UIKit

class DrawingSplitViewController: UISplitViewController {
    
    var container: DIContainable?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let canvas = viewController(for: .secondary) as? PassiveCanvasViewController
        canvas?.container = container
    }
}
