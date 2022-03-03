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
        //rectangleGenerationButton 의 delegate 프로퍼티 에서 옵셔녈로 설정했던 프로토콜 타입을 현재 뷰컨트롤러로 설정해준다. (이때 뷰컨트롤러는 해당프로토콜을 채택하고있어야함).
        rectangleGenerationButton.delegate = self
        plane.delegate = self
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
            os_log(.debug,"사각형 포착: \(rect)")
            let detectedView = view.hitTest(sender.location(in: self.view), with: nil) as! RectangleView
            if detectedView.selected {
                detectedView.configure(didSelect: false)
            }else{
                detectedView.configure(didSelect: true)
            }
            detectedView.selected = !detectedView.selected
        }
    }
    
}

//RectableView 에서 정의한 delegate.didTapGenerateButton() 은 viewController 의 didTapGenerateButton() 을 호출하게 되고
//아래 정의된 함수를 실행하게 된다.
extension ViewController : GenerateRectangleButtonDelegate {
    //사각형 생성 버튼이 눌리면 함수 정의
    func didTapGenerateButton() {
        do {
            let rect = try ShapeFactory(planeWidth: screenWdith, planeHeight: screenHeight - rectangleGenerationButton.frame.height, shapeSize: Size(width: 130, height: 120)).makeRect()
            os_log(.debug, "\(rect)")
            plane.append(rect)
        }catch{
            os_log("")
        }
    }
}

extension ViewController : PlaneDelegate {
    func didAppendRect(rect: Rectangle?) {
        if let appendedRect = rect {
            let rectUI = RectangleView(frame: CGRect(x: appendedRect.point.x, y: appendedRect.point.y, width: appendedRect.size.width, height: appendedRect.size.height))
            rectUI.backgroundColor = UIColor(red: appendedRect.color.red/255, green: appendedRect.color.green/255, blue: appendedRect.color.blue/255, alpha: Double(appendedRect.alpha.rawValue)/10)
            view.addSubview(rectUI)
        }
    }
}
