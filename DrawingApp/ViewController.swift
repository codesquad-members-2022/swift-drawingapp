//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class ViewController: UIViewController {
    private var rectangles = Plane()
    private let rectangleMaker = RandomRectangleMaker()
    let attributer = RightAttributerView()
    
    @IBOutlet weak var rectangleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
        self.view.addSubview(attributer)
        attributer.layout()
    }

    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleView = RandomRectangleView()
        rectangleView.makeRectangleView(width: self.attributer.frame.minX, height: self.rectangleButton.frame.minY)
        
        guard let rectangle = rectangleView.giveRectangle() else{
            let alert = UIAlertController(title: "Warning", message: "사각형 생성에 문제가 있습니다.", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "Okay", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: false)
            return
        }
        
        rectangles.addRectangle(rectangle: rectangle)

        os_log("%@", "\(rectangle.description)")
        self.view.addSubview(rectangleView)
    }
    
}

