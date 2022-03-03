//
//  InspectorItemView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorItemLabelView: InspectorItemView {
    let info: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 5
        return label
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
        self.stackView.addArrangedSubview(info)
        info.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
