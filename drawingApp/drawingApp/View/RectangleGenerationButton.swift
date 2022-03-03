//
//  RectangleGenerationButton.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/03.
//

import UIKit

class RectangleGenerationButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .lightGray
        self.setTitle("사각형", for: .normal)
    }


}
