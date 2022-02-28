//
//  ViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {

    let factory = Factory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (0..<4).forEach { _ in
            let newSquare = factory.makeSquare()
            Log.print("\(newSquare)")
        }
    }


}

