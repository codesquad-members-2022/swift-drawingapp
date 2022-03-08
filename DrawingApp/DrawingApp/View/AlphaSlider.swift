//
//  AlphaSlider.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

class AlphaSlider: UISlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    func configureUI() {
        self.frame.size.width = 200
        self.isEnabled = false
        self.value = 5
        self.maximumValue = 10
        self.minimumValue = 1
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
    }
}
