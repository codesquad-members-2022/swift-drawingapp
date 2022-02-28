//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import UIKit

class DrawingViewController: UIViewController {

    private lazy var squardAddButton = SquareAddButton(frame: CGRect(x: view.center.x - 50, y: view.frame.maxY - 144.0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(squardAddButton)
        setSquareButtonEvent()
    }

    func setSquareButtonEvent(){
        squardAddButton.addTarget(self, action: #selector(squardAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func squardAddButtonTapped(sender: Any){
        var randomLogic = RandomLogic(squareProtocol: self)
        randomLogic.makeSquareViewState()
    }
}
extension DrawingViewController: SquareViewProtocol{
    func makeSquareView(squareViewState: SquareViewState) {
        let squareView = SquareView(squareViewState: squareViewState)
        view.addSubview(squareView)
    }
}
