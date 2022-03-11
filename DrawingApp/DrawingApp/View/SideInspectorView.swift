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
    let backgroundColorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배경색"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let backgroundColorValueView: BackgroundColorView = {
        let view = BackgroundColorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
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
    
    @objc func createRectangleButtonTapped(_ sender: UIButton) {
        delegate?.sideInspectorView(self, buttonDidTapped: sender)
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
        addSubview(backgroundColorLabel)
        addSubview(backgroundColorValueView)
        addSubview(alphaLabel)
        addSubview(alphaSlider)
        addSubview(createRectangleButton)
        
        NSLayoutConstraint.activate([
            backgroundColorLabel.widthAnchor.constraint(equalToConstant: 100),
            backgroundColorLabel.heightAnchor.constraint(equalToConstant: 50),
            backgroundColorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            backgroundColorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            backgroundColorValueView.topAnchor.constraint(equalTo: self.backgroundColorLabel.bottomAnchor),
            backgroundColorValueView.leadingAnchor.constraint(equalTo: self.backgroundColorLabel.leadingAnchor),
            backgroundColorValueView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            backgroundColorValueView.heightAnchor.constraint(equalToConstant: 50),
            
            alphaLabel.topAnchor.constraint(equalTo: self.backgroundColorValueView.bottomAnchor, constant: 20),
            alphaLabel.leadingAnchor.constraint(equalTo: self.backgroundColorLabel.leadingAnchor),
            
            alphaSlider.topAnchor.constraint(equalTo: self.alphaLabel.bottomAnchor, constant: 10),
            alphaSlider.leadingAnchor.constraint(equalTo: self.backgroundColorLabel.leadingAnchor),
            alphaSlider.trailingAnchor.constraint(equalTo: self.backgroundColorValueView.trailingAnchor),
            
            createRectangleButton.leadingAnchor.constraint(equalTo: self.backgroundColorLabel.leadingAnchor),
            createRectangleButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            createRectangleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            createRectangleButton.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
