//
//  CanvasView.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/10.
//

import UIKit

protocol RectangleViewDelegate {
    func addRectangleButtonDidTouch()
    func canvasDidTab(at point: CGPoint)
}

class CanvasView: UIView {
    
    var delgate: RectangleViewDelegate?
    @IBOutlet var rectangleAddButton: UIButton!
    
    
    override func awakeFromNib(){
        self.rectangleAddButton.layer.cornerRadius = 15
    }
    
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    

    @IBAction func addRectangleTouched(_ sender: Any) {
        delgate?.addRectangleButtonDidTouch()
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
            let touchedPoint = sender.location(in: sender.view)
            delgate?.canvasDidTab(at: touchedPoint)
    }
    

        
}
