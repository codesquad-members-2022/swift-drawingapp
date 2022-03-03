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
    
    private var items: [InspectorItemView] {
        [colorButton, alphaSlider]
    }
    
    func bind(plane: Plane) {        
        colorButton.buttonEventHandler = {
            plane.action.changeColorButtonTapped()
        }
        
        alphaSlider.valueChangedHandler = { value in
            let alpha = Alpha.init(rawValue: Int(value))
            plane.action.changeAlphaSliderEvent(alpha)
        }
    }
    
    override func attribute() {
        super.attribute()
        self.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        
        itemStackView.axis = .vertical
        itemStackView.isHidden = true
        
        colorButton.setTitle("배경색")
        
        alphaSlider.setTitle("Alpha")
        alphaSlider.setLimit(min: 0, max: Float(Alpha.max.index - 1))
    }
    
    override func layout() {
        super.layout()
        
        self.addSubview(itemStackView)
        items.forEach {
            itemStackView.addArrangedSubview($0)
        }
        
        itemStackView.translatesAutoresizingMaskIntoConstraints = false
        itemStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        itemStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        itemStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        itemStackView.bottomAnchor.constraint(equalTo: items[items.count - 1].bottomAnchor).isActive = true
    }
    
    func updateInspector(in square: Square?) {
        itemStackView.isHidden = square == nil
        
        guard let square = square else {
            return
        }
        
        let inspectorData = square.inspectorData
        colorButton.setButtonTitle(inspectorData.hexColor)
        alphaSlider.setValue(Float(inspectorData.alpha.index))
    }
}
