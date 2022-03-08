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
        
        model.delegate = self
    }
    
    // MARK:- Outlets
    @IBOutlet weak var canvas: UIView!
    
    // MARK:- Actions
    @IBAction func touchedCreateRect(_ sender: Any) {
        model.createRect()
    }
}

// MARK:- PlaneDelegate
extension ViewController: PlaneDelegate {
    func didCreate(rect: Rectangle) {
        let view = UIView(frame: CGRect(origin: CGPoint(x: rect.point.x, y: rect.point.y), size: CGSize(width: rect.size.width, height: rect.size.height)))
        view.backgroundColor = .red
        canvas.addSubview(view)
    }
}
