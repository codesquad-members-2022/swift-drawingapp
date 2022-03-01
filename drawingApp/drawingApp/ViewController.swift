//
//  ViewController.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//

import UIKit
import OSLog
class ViewController: UIViewController {
    
    let screenWdith = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    //사각형을 생성하는 버튼 만들기
    let rectangleGenerationButton : UIButton = {
       let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width/2 - (130/2), y: UIScreen.main.bounds.height - 100, width: 130, height: 100))
        button.layer.cornerRadius = 10
        button.backgroundColor = .lightGray
        button.setTitle("사각형", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleGenerationButton)
        rectangleGenerationButton.addTarget(self, action: #selector(didTapButton), for: .touchDown)
    }
    
    //Rectangle 생성 함수
    @objc func didTapButton () {
        if let rect = RectangleFactory(screenWidth: screenWdith, screenHeight: screenHeight).makeRect() {
            os_log(.debug, "\(rect.description)")
            let rectangleView = UIView(frame: CGRect(x: rect.getPoint().x, y: rect.getPoint().y, width: rect.getSize().width, height: rect.getSize().height))
            rectangleView.backgroundColor = UIColor(red: rect.getColor().red/255.0, green: rect.getColor().green/255.0, blue: rect.getColor().blue/255.0, alpha: rect.getAlpha()/10.0)
            self.view.addSubview(rectangleView)
        }
    }
   

}

