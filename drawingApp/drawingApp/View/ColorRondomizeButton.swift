//
//  ColorRondomizeButton.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/04.
//

import UIKit

protocol ColorRondomizeButtonDelegate {
    func generateRandomColor(sender: ColorRondomizeButton)
}


class ColorRondomizeButton: UIButton {

    var delegate : ColorRondomizeButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.backgroundColor = .tintColor
        self.layer.cornerRadius = 10
        self.setTitle("", for: .normal)
        self.tag = 1
    }
    
    @objc func didTapButton(){
        delegate?.generateRandomColor(sender: self)
    }
}
