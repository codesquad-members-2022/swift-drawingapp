//
//  AlphaSlider.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/06.
//

import UIKit
protocol AlphaSliderDelegate {
    func changeAlpha(sender : AlphaSlider)
}
class AlphaSlider: UISlider {
    
    var delegate : AlphaSliderDelegate?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        self.addTarget(self, action: #selector(didSlide), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.minimumValue = 0
        self.maximumValue = 10
    }
    
    @objc func didSlide () {
        delegate?.changeAlpha(sender : self)
    }
}
