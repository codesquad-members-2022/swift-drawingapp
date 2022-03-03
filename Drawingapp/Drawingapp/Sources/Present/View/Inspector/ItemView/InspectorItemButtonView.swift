//
//  InspectorItemButtonView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorItemButtonView: InspectorItemView {
    let button = UIButton()
    
    override func attribute() {
        super.attribute()
        
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
    }
    
    override func layout() {
        super.layout()
        self.stackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setButtonTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }
}
