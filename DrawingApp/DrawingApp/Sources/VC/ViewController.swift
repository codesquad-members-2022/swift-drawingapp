//
//  ViewController.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    @IBOutlet weak var canvas: UIView!
    @IBOutlet weak var controlView: ControlView!
    
    private var plane = Plane()
    
    private var rectengles = [Rectangle: UIView]() // 이 안에 Rectangle 값이랑, 그에 맞는 view를 넣어
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(canvas)

        plane.delegate = self
        controlView.delegate = self

    }
    
}

extension ViewController: ControlViewDelegate {

    func didpressColorChangeButton() {
        print("")
    }
    
    func didMoveSlider() {
        print("")
        
    }
    
    func didpressCreateRectangleButton() {
        plane.createRectangle()
    }
    
}

extension ViewController: PlaneDelegate {
    
    func didCreatRectangel(rectangle: Rectangle) {
        let view = UIView.init(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        
        view.backgroundColor = Convert.toUIColor(color: rectangle.color, alpha: rectangle.alpha)
        
        rectengles[rectangle] = view
        self.canvas.addSubview(view)
        
        print(rectangle.point)
    }
    
    func didSelect() {
        print("")
    }
    
    
}
