//
//  ViewController.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/01.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    private var model = Plane()
    private var rectengles = [Rectangle: RectengleView]() // 이 안에 Rectangle 값이랑, 그에 맞는 view를 넣어
    
    @IBOutlet weak var canvas: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func createRectangle(_ sender: UIButton) {
        let rectangle = model.createRectangle(marginX: canvas.bounds.width, marginY: canvas.bounds.height)
    
        let view = RectengleView.init(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        
        self.canvas.addSubview(view)
    }
    
    
}
