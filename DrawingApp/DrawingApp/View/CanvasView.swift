//
//  CanvasView.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/10.
//

import UIKit

class CanvasView: UIView {
    
    var delgate: RectangleViewDelegate?
    @IBOutlet var rectangleAddButton: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        customInit()
    }
    
    
    
    @IBAction func addRectangleTouched(_ sender: Any) {
        delgate?.touchedAddRectangleButton()
    }
    
    func customInit() {
            if let view = Bundle.main.loadNibNamed("CanvasView", owner: self, options: nil)?.first as? UIView {
                view.frame = self.bounds
                addSubview(view)
            }
        rectangleAddButton.layer.cornerRadius = 15
        }
        
}
