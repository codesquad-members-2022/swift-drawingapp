//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import UIKit
import os

class DrawingViewController: UIViewController {

    private lazy var squardAddButton = SquareAddButton(frame: CGRect(x: view.center.x - 50, y: view.frame.maxY - 144.0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(squardAddButton)
        setSquareButtonEvent()
        let squareFactory = SquareFactory(squareProtocol: self)
        for i in 0 ..< 4{
            squareFactory.makeRandomSquare()
        }
    }

    func setSquareButtonEvent(){
        squardAddButton.addTarget(self, action: #selector(squardAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func squardAddButtonTapped(sender: Any){
        let squareView = SquareView(frame: CGRect(x: RandomMax.x.randomValue, y: RandomMax.y.randomValue, width: 150, height: 120))
        let red = CGFloat(RandomMax.color.randomValue)/255
        let green = CGFloat(RandomMax.color.randomValue)/255
        let blue = CGFloat(RandomMax.color.randomValue)/255
        let alpha = CGFloat(RandomMax.alpha.randomValue)
        squareView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        view.addSubview(squareView)
    }
}
extension DrawingViewController: SquareViewProtocol{
    func logging(square: Square) {
        let logger = Logger()
        logger.info("Rect : \(square.description)")
    }
}
