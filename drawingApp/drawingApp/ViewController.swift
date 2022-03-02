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
        Color(
        do {
            UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: .random(in: <#T##ClosedRange<CGFloat>#>))
            let rect = try RectangleFactory(screenWidth: screenWdith, screenHeight: screenHeight).makeRect()
            os_log(.debug, "\(rect.description)")
            let rectangleView = UIView(frame: CGRect(x: rect.point.x, y: rect.point.y, width: rect.size.width, height: rect.size.height))
            rectangleView.backgroundColor = UIColor(red: rect.color.red/255.0, green: rect.color.green/255.0, blue: rect.color.blue/255.0, alpha: Double(rect.alpha)/10.0)
            self.view.addSubview(rectangleView)
        }catch{
            os_log("")
        }
       
    }
   

}

