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
        
        
        for _ in 0..<4 {
            let drawableFactory = DrawableFactory()
            let decoableFactory = DecoableFactory()
            
            let id = IDFactory.makeRandomID()
            
            guard let size = drawableFactory.makeDrawable(drawType: .size, horizontal: 120,vertical: 150) as? Size else { return }
            guard let origin = drawableFactory.makeRandomDrawable(drawType: .point) as? Point else { return }
            
            guard let backgroundColor = decoableFactory.makeRandomDecoable(decoType: .RGB) as? RGB else { return }
            guard let alpha = decoableFactory.makeRandomDecoable(decoType: .alpha) as? Alpha else { return }
            
            
            let rect = Rectangle(id: id, origin: origin, size: size, backGroundColor: backgroundColor, alpha: alpha)
            
            os_log(.default, "\(rect)")
        }
    }
}

