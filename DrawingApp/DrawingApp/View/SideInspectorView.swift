//
//  SideInspectorView.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/09.
//

import Foundation
import UIKit

class SideInspectorView: UIView {
    var delegate: SideInspectorViewDelegate? // VC에 뷰 변경 기능을 위임하기 위한 delegate 속성

    // TODO: component 속성 정의
    let colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("#000000", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.addTarget(self, action: #selector(colorButtonDidTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    let backgroundColorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배경색"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let alphaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "투명도"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let alphaSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = Float(Alpha.one.opacity)
        slider.maximumValue = Float(Alpha.ten.opacity)
        slider.value = Float(Alpha.five.opacity)
        slider.addTarget(self, action: #selector(sliderValueDidChanged(_:)), for: .allTouchEvents)
        return slider
    }()
    
    let createRectangleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("사각형", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(createRectangleButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func colorButtonDidTapped(_ sender: UIButton) {
        delegate?.sideInspectorViewDidTappedColorButton(sender)
    }
    
    @objc func createRectangleButtonTapped(_ sender: UIButton) {
        delegate?.sideInspectorViewDidTappedRectangleButton()
    }
    
    @objc func sliderValueDidChanged(_ slider: UISlider) {
        delegate?.sideInspectorViewSliderValueDidChanged(slider)
    }
    
    // TODO: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    
    // TODO: set layout
    func setLayout() {
        backgroundColor = .systemGray5
        addSubview(colorButton)
        addSubview(backgroundColorLabel)
        addSubview(alphaLabel)
        addSubview(alphaSlider)
        addSubview(createRectangleButton)
        
        NSLayoutConstraint.activate([
            backgroundColorLabel.widthAnchor.constraint(equalToConstant: 100),
            backgroundColorLabel.heightAnchor.constraint(equalToConstant: 50),
            backgroundColorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            backgroundColorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            colorButton.heightAnchor.constraint(equalToConstant: 60),
            colorButton.topAnchor.constraint(equalTo: self.backgroundColorLabel.bottomAnchor),
            colorButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            colorButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            alphaLabel.topAnchor.constraint(equalTo: self.colorButton.bottomAnchor, constant: 20),
            alphaLabel.leadingAnchor.constraint(equalTo: self.backgroundColorLabel.leadingAnchor),
            
            alphaSlider.topAnchor.constraint(equalTo: self.alphaLabel.bottomAnchor, constant: 10),
            alphaSlider.leadingAnchor.constraint(equalTo: self.backgroundColorLabel.leadingAnchor),
            alphaSlider.trailingAnchor.constraint(equalTo: self.colorButton.trailingAnchor),
            
            createRectangleButton.leadingAnchor.constraint(equalTo: self.backgroundColorLabel.leadingAnchor),
            createRectangleButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            createRectangleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            createRectangleButton.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
