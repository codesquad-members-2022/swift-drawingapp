//
//  AlphaStepper.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

class AlphaStepper: UIStepper {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureUI()
    }
    
    func configureUI() {
        self.value = 5
        self.maximumValue = 10
        self.minimumValue = 1
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
    }
}
