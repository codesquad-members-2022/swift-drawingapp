//
//  ViewController.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/02/28.
//

import UIKit
import OSLog

class MainViewController: UIViewController {

    var plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        configureRectangleButton()
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    
    //버튼 정의
    private func configureRectangleButton() {
        // 820 X 1180
        let width = 150.0
        let height = 100.0
        let x = (Point.maxX / 2) - (width / 2)
        let y = (Point.maxY - height) - 30
        
        let squareImage = UIImage(systemName: "square")
        let highlightedImage = UIImage(systemName: "square.fill")
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = "사각형"
        
        configuration.image = squareImage
        
        configuration.imagePlacement = .top
        configuration.imagePadding = 20
        
        configuration.background.backgroundColor = .secondarySystemBackground
        configuration.background.cornerRadius = 10
        
        let button = UIButton(configuration: configuration, primaryAction: makeRectangleAction())
        
        button.tintColor = .black
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        
        //터치시 변화를 보여주기 위해 선언함.
        button.configurationUpdateHandler = { button in
            var configuration = button.configuration
            configuration?.image = button.isHighlighted ? highlightedImage : squareImage
            button.configuration = configuration
        }
        
        view.addSubview(button)
    }
    
    //버튼 액션정의
    private func makeRectangleAction() -> UIAction {
        let action = UIAction {_ in
            let id = IDFactory.makeRandomID()
            let size = Size(width: 150, height: 120)
            let point = PointFactory.makeRandomPoint()
            let rgb = RGBFactory.makeRandomRGB()
            let alpha = AlphaFactory.makeRandomAlpha()
            
            let rect = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
            let rectOnView = UIView(rect: rect, rgb: rgb, alpha: alpha)
            
            self.plane.rectangles.append(rectOnView)
            self.view.addSubview(rectOnView)
        }
        return action
    }
}

extension MainViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let locationView = self.view.hitTest(touch.location(in: self.view), with: nil)
        
        //터치한 곳의 View의 크기를 비교해서 직사각형의 유무를 파악합니다.
        if locationView?.frame.size == CGSize(width: 150, height: 120) {
            self.plane.seletedRectangle.layer.borderWidth = 0.0
            
            locationView?.layer.borderWidth = 1.0
            locationView?.layer.borderColor = UIColor.black.cgColor
            self.plane.seletedRectangle = locationView ?? UIView()
        } else {
            
            self.plane.seletedRectangle.layer.borderWidth = 0.0
        }
        
        return true
    }
}

