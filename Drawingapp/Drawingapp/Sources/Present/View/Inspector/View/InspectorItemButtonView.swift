//
//  InspectorItemButtonView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorItemButtonView: InspectorItemView {
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
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
    
    func bind(action: @escaping () -> Void) {
        button.addAction(UIAction{ _ in
            action()
        }, for: .touchUpInside)
    }
    
    func addMenu(menu: UIMenu) {
        button.menu = menu
    }
    
    func setTitle(title: String) {
        button.setTitle(title, for: .normal)
    }
}
