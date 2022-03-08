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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGesture.delegate = self
        self.canvas.addGestureRecognizer(tapGesture)
    }
    
    // MARK:- Outlets
    @IBOutlet weak var canvas: UIView!
    
    // MARK:- Actions
    @IBAction func touchedCreateRect(_ sender: Any) {
        model.createRect()
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) { }
}

// MARK:- PlaneDelegate
extension ViewController: PlaneDelegate {
    func didSelected(rect: Rectangle?) {
        // TODO: view 에 선택한 Rectangle의 background, alpha 정보 업뎃
    }
    
    func didCreate(rect: Rectangle) {
        let view = UIView(frame: CGRect(origin: CGPoint(x: rect.point.x, y: rect.point.y), size: CGSize(width: rect.size.width, height: rect.size.height)))
        view.backgroundColor = .red
        canvas.addSubview(view)
    }
}

// MARK:- UIGestureRecognizerDelegate
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchedPoint = touch.location(in: gestureRecognizer.view)
        let point = Point(x: Double(touchedPoint.x), y: Double(touchedPoint.y))
        model.selectRect(inside: point)
        return true
    }
}
