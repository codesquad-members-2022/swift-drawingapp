//
//  SideInspectorView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/08.
//

import UIKit

class SideInspectorView: UIStackView {
    
    //MARK: Create Components
    
    private let backgroundMenuStackView: UIStackView = {
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
    
    let backgroundColorValueButton: UIButton = {
        let button = UIButton()
        button.setTitle("#000000", for: .normal)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray3.cgColor
        return button
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
    
    private let alphaValueStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let alphaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "투명도"
        return label
    }()
    
    private let alphaValueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.backgroundColor = .systemGray5
        label.textAlignment = .center
        return label
    }()
    
    let alphaPlusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    let alphaMinusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .systemGray4
        return button
    }()
    
    //MARK: Initialize

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    //MARK: Configure Components
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray6
        
        self.addSubview(backgroundMenuStackView)
        self.addSubview(alphaMenuStackView)
        
        layoutBackgroundMenuStackView()
        layoutAlphaMenuStackView()
    }
    
    private func layoutBackgroundMenuStackView() {
        backgroundMenuStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        backgroundMenuStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        backgroundMenuStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        backgroundMenuStackView.addArrangedSubview(backgroundColorLabel)
        
        backgroundMenuStackView.addArrangedSubview(backgroundColorValueButton)
        layoutBackgroundColorValueButton()
    }
    
    private func layoutBackgroundColorValueButton() {
        backgroundColorValueButton.leadingAnchor.constraint(equalTo: backgroundMenuStackView.leadingAnchor).isActive = true
        backgroundColorValueButton.trailingAnchor.constraint(equalTo: backgroundMenuStackView.trailingAnchor).isActive = true
        backgroundColorValueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func layoutAlphaMenuStackView() {
        alphaMenuStackView.topAnchor.constraint(equalTo: backgroundMenuStackView.bottomAnchor, constant: 30).isActive = true
        alphaMenuStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        alphaMenuStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        alphaMenuStackView.addArrangedSubview(alphaLabel)
        alphaMenuStackView.addArrangedSubview(alphaValueStackView)
        layoutAlphaValueStackView()
    }
    
    private func layoutAlphaValueStackView() {
        alphaValueStackView.leadingAnchor.constraint(equalTo: alphaMenuStackView.leadingAnchor).isActive = true
        alphaValueStackView.trailingAnchor.constraint(equalTo: alphaMenuStackView.trailingAnchor).isActive = true
        
        alphaValueStackView.addArrangedSubview(alphaPlusButton)
        alphaValueStackView.addArrangedSubview(alphaValueLabel)
        alphaValueStackView.addArrangedSubview(alphaMinusButton)
    }
    
    //MARK: Functions
    
    func setBackgroundColorValueButtonTitle(by text: String) {
        backgroundColorValueButton.setTitle(text, for: .normal)
    }

    func clearBackgroundColorValueButtonTitle() {
        backgroundColorValueButton.setTitle("", for: .normal)
    }

    func setBackgroundColorValueButtonColor(by color: Color) {
        backgroundColorValueButton.backgroundColor = UIColor(red: color.red / 255.0,
                                                             green: color.green / 255.0,
                                                             blue: color.blue / 255.0,
                                                             alpha: 1.0)
    }

    func clearBackgroundColorValueButtonColor() {
        backgroundColorValueButton.backgroundColor = .systemGray5
    }
    
    func setAlphaValueLabelText(by alpah: Alpha) {
        alphaValueLabel.text = "\(alpah.value)"
    }
    
    func clearAlphaValueLabelText() {
        alphaValueLabel.text = "0"
    }
    
    func disableAlphaPlusButton() {
        alphaPlusButton.isEnabled = false
    }
    
    func enableAlphaPlusButton() {
        alphaPlusButton.isEnabled = true
    }
    
    func disableAlphaMinusButton() {
        alphaMinusButton.isEnabled = false
    }
    
    func enableAlphaMinusButton() {
        alphaMinusButton.isEnabled = true
    }
}
