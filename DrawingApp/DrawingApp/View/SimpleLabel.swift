//
//  SimpleLabel.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

class SimpleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configure()
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.configure()
    }
    
    private func configure() {
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        self.adjustsFontSizeToFitWidth = true
        self.sizeToFit()
    }
}
