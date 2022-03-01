//
//  inspectorView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorView: BaseView {
    
    let itemStackView = UIStackView()
    let colorButton = InspectorItemButtonView()
    let alphaSlider = InspectorSliderView()
    
    func bind(plane: Plane) {
        colorButton.button.addAction(UIAction{ _ in
            plane.action.changeColorButtonTapped()
        }, for: .touchUpInside)
        
        alphaSlider.slider.addAction(UIAction{ _ in
            plane.action.changeAlphaSliderEvent(self.alphaSlider.slider.value)
        }, for: .touchDragInside)
    }
    
    override func attribute() {
        super.attribute()
        self.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        
        itemStackView.axis = .vertical
        itemStackView.isHidden = true
        
        colorButton.title.text = "배경색"
        
        alphaSlider.title.text = "Alpha"
        alphaSlider.slider.minimumValue = 0
        alphaSlider.slider.maximumValue = Float(Alpha.max.index - 1)
    }
    
    override func layout() {
        super.layout()
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        self.addSubview(itemStackView)
        itemStackView.addArrangedSubview(colorButton)
        itemStackView.addArrangedSubview(alphaSlider)
        
        itemStackView.translatesAutoresizingMaskIntoConstraints = false
        itemStackView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
        itemStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        itemStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        itemStackView.bottomAnchor.constraint(equalTo: alphaSlider.bottomAnchor).isActive = true
    }
    
    func updateInspector(in square: Square?) {
        guard let square = square else {
            itemStackView.isHidden = true
            return
        }
        itemStackView.isHidden = false
        
        let inspectorData = square.inspectorData
        colorButton.button.setTitle(inspectorData.hexColor, for: .normal)
        alphaSlider.slider.value = Float(inspectorData.alpha.index)
    }
}
