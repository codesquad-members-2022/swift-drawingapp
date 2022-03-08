//
//  ViewController.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    private let model = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try Log.shared.config()
        } catch {
            print(error.localizedDescription)
        }
        
        let rect = ShapeFactoryType.square(length: 20).make()
        Log.shared.print(logLevel: .default, message: rect.description)
    }
    
    // MARK:- Actions
    @IBAction func touchedCreateRect(_ sender: Any) {
        model.createRect()
    }
}
