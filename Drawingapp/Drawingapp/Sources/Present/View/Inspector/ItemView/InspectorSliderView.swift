//
//  InspectorSliderView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorSliderView: InspectorItemView {
    let slider = UISlider()
    
    override func attribute() {
        super.attribute()
    }
    
    override func layout() {
        super.layout()
        self.stackView.addArrangedSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
