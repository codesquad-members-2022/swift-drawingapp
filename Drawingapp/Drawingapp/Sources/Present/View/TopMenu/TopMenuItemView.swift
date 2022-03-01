//
//  TopMenuItemView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class TopMenuItemView: UIView {
    let icon = UIImageView()
    let button = UIButton()
    
    init() {
        super.init(frame: .zero)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func attribute() {
        self.backgroundColor = .clear
    }
    
    func layout() {        
        self.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: self.topAnchor, constant: 10 ).isActive = true
        icon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
