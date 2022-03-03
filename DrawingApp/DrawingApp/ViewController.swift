//
//  ViewController.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/02/28.
//

import UIKit
import OSLog

class ViewController: UIViewController {

        
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
            configureRectangleButton()
        
            let id = IDFactory.makeRandomID()
            let size = SizeFactory.makeRandomSize()
            let point = PointFactory.makeRandomPoint()
            let rgb = RGBFactory.makeRandomRGB()
            let alpha = AlphaFactory.makeRandomAlpha()
            
            let rect = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
            
            
        
        
            os_log(.default, "\(rect)")
    }
    
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
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        
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
    
    
}

