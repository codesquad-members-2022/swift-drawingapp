//
//  SideInspectorView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/08.
//

import UIKit

class SideInspectorView: UIStackView {
    
    //MARK: Create Components
    
    //TODO: VC로부터 값 받아서 Set or Clear 메소드 구현
    
    private let backgroundMenuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private let alphaMenuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private let backgroundColorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배경색"
        return label
    }()
    
    private let backgroundColorValueButton: UIButton = {
        let button = UIButton()
        button.setTitle("#000000", for: .normal)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        return button
    }()
    
    private let alphaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "투명도"
        return label
    }()
    
    private let alphaSlider: UISlider = {
        let slider = UISlider()
        return slider
    }()
    
    //MARK: Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        
        self.addSubview(backgroundMenuStackView)
        self.addSubview(alphaMenuStackView)
        
        layoutBackgroundMenuStackView()
        layoutAlphaMenuStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        
        self.addSubview(backgroundMenuStackView)
        self.addSubview(alphaMenuStackView)
        
        layoutBackgroundMenuStackView()
        layoutAlphaMenuStackView()
    }
    
    //MARK: Configure Components
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
    }
    
    private func layoutAlphaMenuStackView() {
        alphaMenuStackView.topAnchor.constraint(equalTo: backgroundMenuStackView.bottomAnchor, constant: 30).isActive = true
        alphaMenuStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        alphaMenuStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
        alphaMenuStackView.addArrangedSubview(alphaLabel)
        
        alphaMenuStackView.addArrangedSubview(alphaSlider)
        layoutAlphaSlider()
    }
    
    private func layoutBackgroundMenuStackView() {
        backgroundMenuStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        backgroundMenuStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        backgroundMenuStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        
        backgroundMenuStackView.addArrangedSubview(backgroundColorLabel)
        
        backgroundMenuStackView.addArrangedSubview(backgroundColorValueButton)
        layoutBackgroundColorValueButton()
    }
    
    private func layoutBackgroundColorValueButton() {
        backgroundColorValueButton.leadingAnchor.constraint(equalTo: backgroundMenuStackView.leadingAnchor).isActive = true
        backgroundColorValueButton.trailingAnchor.constraint(equalTo: backgroundMenuStackView.trailingAnchor).isActive = true
        backgroundColorValueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func layoutAlphaSlider() {
        alphaSlider.leadingAnchor.constraint(equalTo: alphaMenuStackView.leadingAnchor).isActive = true
        alphaSlider.trailingAnchor.constraint(equalTo: alphaMenuStackView.trailingAnchor).isActive = true
    }
}
