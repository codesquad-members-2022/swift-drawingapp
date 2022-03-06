//
//  AlphaStepper.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/07.
//

import UIKit
protocol AlphaStepperDelegate {
    func changeAlpha(sender : AlphaStepper)
}
class AlphaStepper: UIStepper {

    var delegate : AlphaStepperDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(didTabStepper), for: .valueChanged)
        setup ()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
 
    func setup () {
        self.minimumValue = 0
        self.maximumValue = 10
        self.wraps = false
        self.stepValue = 1
    }
    
    @objc func didTabStepper(){
        delegate?.changeAlpha(sender: self)
    }
}
