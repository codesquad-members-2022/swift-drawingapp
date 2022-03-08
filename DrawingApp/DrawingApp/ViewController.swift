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
    @IBOutlet weak var informationView: InputView!
    
    // MARK:- Actions
    @IBAction func touchedCreateRect(_ sender: Any) {
        let size = Size(width: Int(canvas.frame.size.width), height: Int(canvas.frame.size.height))
        model.createRect(in: size)
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) { }
}

// MARK:- PlaneDelegate
extension ViewController: PlaneDelegate {
    func didSelected(rect: Rectangle?) {
        informationView.loadView(with: rect)
        // TODO: 선택한 사각형의 테두리 그리기
    }
    
    func didCreate(rect: Rectangle) {
        let rectView = RectangleView(rect: rect)
        canvas.addSubview(rectView)
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
