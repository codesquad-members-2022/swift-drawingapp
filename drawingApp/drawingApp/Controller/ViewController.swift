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
    var plane = Plane()
    private let rectangleGenerationButton = RectangleGenerationButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleGenerationButton)
        
        rectangleGenerationButton.addTarget(self, action: #selector(didTapButton), for: .touchDown)
        
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTriggered))
        tapGuestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGuestureRecognizer)

    }
    
    override func viewWillLayoutSubviews() {
        rectangleGenerationButton.frame = CGRect(x: screenWdith/2 - (130/2), y: screenHeight - 100, width: 130, height: 100)
    }
    
    @objc func tapTriggered(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        os_log(.debug,"\(point.x),\(point.y)")
        if let rect = plane.detectRect(x: point.x, y: point.y) {
            os_log(.debug,"사각형 발견 : \(rect.id)")
        }
        
    }
    
    
    
    //Rectangle 모델 생성후 Plane 객체에 넘긴다.
    @objc func didTapButton () {
        do {
            let rect = try ShapeFactory(planeWidth: screenWdith, planeHeight: screenHeight - rectangleGenerationButton.frame.height, shapeSize: Size(width: 130, height: 120)).makeRect()
            os_log(.debug, "\(rect)")
//            var rectUI = UIView(frame: CGRect(x: rect.point.x, y: rect.point.y, width: rect.size.width, height: rect.size.height))
//            rectUI.backgroundColor = UIColor(red: rect.color.red/255, green: rect.color.green/255, blue: rect.color.blue/255, alpha: Double(rect.alpha.rawValue)/10)
//            view.addSubview(rectUI)
            plane.append(rect)
        }catch{
            os_log("")
        }
       
    }
   

}

