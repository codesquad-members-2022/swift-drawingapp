//
//  InspectorSliderView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorSliderView: InspectorItemView {
    let sliderStackView = UIStackView()
    let minusButton = UIButton()
    let plusButton = UIButton()
    let slider = UISlider()
    
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
    
    func addValue(_ addValue: Float) {
        setValue(slider.value + addValue)
    }
    
    func setValue(_ value: Float) {
        slider.setValue(value, animated: false)
        updateButtons()
    }
    
    func updateButtons() {
        minusButton.isEnabled = slider.value > slider.minimumValue
        plusButton.isEnabled = slider.value < slider.maximumValue
    }
}
