//
//  ControllerView.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/10.
//

import UIKit


protocol ControllerViewDelegate {
    func backgroundButtonDidTouch()
    func alphaSliderDidChange(_ value: Float)
}


class ControllerView: UIView {

    @IBOutlet var backgroundButton: UIButton!
    @IBOutlet var alphaSlider: UISlider!
    
    var delegate: ControllerViewDelegate?
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    

    @IBAction func touchBackgroundButton(_ sender: Any) {
            delegate?.backgroundButtonDidTouch()
    }
    
   
    @IBAction func changedAlphaSlider(_ sender: UISlider) {
            delegate?.alphaSliderDidChange(sender.value)
    }
}
