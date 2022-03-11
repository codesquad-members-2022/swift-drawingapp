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
    
    private func configureButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
        setTitle("사각형", for: .normal)
        setTitleColor(.gray, for: .normal)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray6.cgColor
    }
}
