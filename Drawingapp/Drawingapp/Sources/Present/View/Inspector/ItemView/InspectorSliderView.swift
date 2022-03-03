//
//  InspectorSliderView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorSliderView: InspectorItemView {
    private let sliderStackView = UIStackView()
    private let minusButton = UIButton()
    private let plusButton = UIButton()
    private let slider = UISlider()
    
    var valueChangedHandler: (Float) -> Void = { _ in }
    
    override func bind() {
        super.bind()
        minusButton.addAction(UIAction{ _ in
            self.addValue(-1)
        }, for: .touchUpInside)
        
        plusButton.addAction(UIAction{ _ in
            self.addValue(1)
        }, for: .touchUpInside)
        
        slider.addAction(UIAction{ _ in
            self.valueChangedHandler(self.slider.value)
        }, for: .valueChanged)
    }
    
    override func attribute() {
        super.attribute()
        
        sliderStackView.axis = .horizontal
        sliderStackView.spacing = 5
        
        minusButton.setImage(UIImage(named: "ic_minus"), for: .normal)
        plusButton.setImage(UIImage(named: "ic_plus"), for: .normal)
    }
    
    override func layout() {
        super.layout()
        self.stackView.addArrangedSubview(sliderStackView)
        
        sliderStackView.addArrangedSubview(minusButton)
        sliderStackView.addArrangedSubview(slider)
        sliderStackView.addArrangedSubview(plusButton)
        
        sliderStackView.translatesAutoresizingMaskIntoConstraints = false
        sliderStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        slider.translatesAutoresizingMaskIntoConstraints = false
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
