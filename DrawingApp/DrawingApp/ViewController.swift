//
//  ViewController.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/02.
//

import UIKit

class ViewController: UIViewController {

    private let model = Plane()
    private var rectangles = [Rectangle: RectangleView]()
    private var previousSelectedRectView: RectangleView?
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
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
}

// MARK:- PlaneDelegate
extension ViewController: PlaneDelegate {
    func didSelected(rect: Rectangle?) {
        if rect == nil {
            self.previousSelectedRectView?.deHighlight()
            self.previousSelectedRectView = nil
        }
        informationView.loadView(with: rect)
    }
    
    func didCreate(rect: Rectangle) {
        let rectView = RectangleView(rect: rect)
        canvas.addSubview(rectView)
        self.rectangles[rect] = rectView
    }
}

// MARK:- UIGestureRecognizerDelegate
extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchedView = gestureRecognizer.view else {
            return false
        }
        let touchedPoint = touch.location(in: touchedView)
        let point = Point(x: Double(touchedPoint.x), y: Double(touchedPoint.y))
        model.selectRect(inside: point)
        return true
    }
}
