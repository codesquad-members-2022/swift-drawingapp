//
//  InspectorItemView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorItemLabelView: InspectorItemView {
    let info = UILabel()
    
    override func attribute() {
        super.attribute()
        
        info.textAlignment = .center
        info.textColor = .systemGray4
        info.backgroundColor = .clear
        info.layer.borderWidth = 1
        info.layer.borderColor = UIColor.lightGray.cgColor
        info.layer.cornerRadius = 5
        info.text = "info Message"
    }
    
    override func layout() {
        super.layout()
        self.stackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
