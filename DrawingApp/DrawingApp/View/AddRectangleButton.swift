//
//  AddRectangleButton.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/08.
//

import UIKit

class AddRectangleButton: UIButton {
    
    //MARK: Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }
    
    //MARK: Configure Components
    
    func configureButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray6
        self.setTitle("사각형", for: .normal)
        self.setTitleColor(.gray, for: .normal)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray6.cgColor
        
        self.addTarget(superview, action: #selector(ViewController.addRectangleButtonTouched), for: .touchUpInside)
    }
}
