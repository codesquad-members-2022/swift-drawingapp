//
//  InspectorMenuButtonView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation
import UIKit

class InspectorMenuButtonView: InspectorItemView {
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    private func layout() {
        self.stackView.addArrangedSubview(button)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
