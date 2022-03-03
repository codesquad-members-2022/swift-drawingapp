//
//  InspectorSliderView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorSliderView: InspectorItemView {
    private let sliderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_minus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
        layout()
    }
    
    private func bind() {
        minusButton.addAction(UIAction{ _ in
            self.addValue(-1)
        }, for: .touchUpInside)

        plusButton.addAction(UIAction{ _ in
            self.addValue(1)
        }, for: .touchUpInside)
    }
        
    private func layout() {
        self.stackView.addArrangedSubview(sliderStackView)
        
        sliderStackView.addArrangedSubview(minusButton)
        sliderStackView.addArrangedSubview(slider)
        sliderStackView.addArrangedSubview(plusButton)
        
        sliderStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func updateButtonsState() {
        minusButton.isEnabled = slider.value > slider.minimumValue
        plusButton.isEnabled = slider.value < slider.maximumValue
    }
    
    private func addValue(_ value: Float) {
        slider.value += value
        slider.sendActions(for: .valueChanged)
        updateButtonsState()
    }
    
    func setValue(_ value: Float) {
        slider.value = value
        updateButtonsState()
    }
    
    func setLimit(min: Float, max: Float) {
        slider.minimumValue = min
        slider.maximumValue = max
    }
}
