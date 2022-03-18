//
//  AddButtonFactory.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/18.
//

import UIKit

class AddButtonFactory {
    static func createButton(name: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray5
        button.setTitle(name, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray2.cgColor
        return button
    }
}

