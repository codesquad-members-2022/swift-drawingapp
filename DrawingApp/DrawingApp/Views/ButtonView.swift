//
//  ButtonView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/18.
//

import UIKit

class ButtonView: UIView {
    
    let rectangleButton: UIButton = {
        return AddButtonFactory.createButton(name: "사각형")
    }()

    let pictureButton: UIButton = {
        return AddButtonFactory.createButton(name: "사진")
    }()

    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(buttonStackView)
        layoutButtonStackView()
    }
    
    private func layoutButtonStackView() {
        buttonStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        buttonStackView.addArrangedSubview(rectangleButton)
        buttonStackView.addArrangedSubview(pictureButton)
        layoutButtons()
    }
    
    private func layoutButtons() {
        for button in buttonStackView.subviews {
            button.widthAnchor.constraint(equalToConstant: 100).isActive = true
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
    }
    
}
