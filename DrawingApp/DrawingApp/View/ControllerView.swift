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

    @IBOutlet var alphaSlider: UISlider!
    @IBOutlet var backgroundButton: UIButton!
    var delegate: ControllerViewDelegate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        customInit()
    }
    
    
    func customInit() {
            if let view = Bundle.main.loadNibNamed("ControllerView", owner: self, options: nil)?.first as? UIView {
                view.frame = self.bounds
                addSubview(view)
            }
        }

    @IBAction func touchedBackgroundButton(_ sender: Any) {
        delegate?.backgroundButtonDidTouch()
    }
    
    @IBAction func changedAlphaSlider(_ sender: UISlider) {
        delegate?.alphaSliderDidChange(sender.value)
    }
    
}
