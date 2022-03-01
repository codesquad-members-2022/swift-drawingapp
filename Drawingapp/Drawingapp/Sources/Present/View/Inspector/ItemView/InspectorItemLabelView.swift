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
        
        info.backgroundColor = .lightGray
        info.text = "asadsad"
    }
    
    override func layout() {
        super.layout()
        self.stackView.addArrangedSubview(info)
        info.translatesAutoresizingMaskIntoConstraints = false
        info.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
