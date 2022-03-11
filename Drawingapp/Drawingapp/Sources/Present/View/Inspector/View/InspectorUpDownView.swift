//
//  InspectorUpDownView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/10.
//

import Foundation
import UIKit

class InspectorUpDownView: UIView {
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let value: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    let upButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_upArrow"), for: .normal)
        return button
    }()
    
    let downButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_downArrow"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        attribute()
        layout()
    }
    
    private func attribute() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
    
    private func layout() {
        self.addSubview(name)
        self.addSubview(value)
        self.addSubview(upButton)
        self.addSubview(downButton)
        
        name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        name.widthAnchor.constraint(equalToConstant: 30).isActive = true
        name.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        value.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 10).isActive = true
        value.rightAnchor.constraint(equalTo: upButton.leftAnchor, constant: -10).isActive = true
        value.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true

        upButton.rightAnchor.constraint(equalTo: downButton.leftAnchor, constant: -5).isActive = true
        upButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        upButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        downButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        downButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        downButton.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
