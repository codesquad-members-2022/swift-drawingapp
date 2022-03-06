//
//  StepperLabel.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/07.
//

import UIKit

class StepperLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup ()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup () {
        self.text = "0"
    }
}
