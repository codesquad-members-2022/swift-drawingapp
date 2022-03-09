//
//  SideInspectorView.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/09.
//

import Foundation
import UIKit

class SideInspectorView: UIView {
    // TODO: component 속성 정의
    let backgroundColorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배경색"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let backgroundColorValueView: BackgroundColorView = {
        let view = BackgroundColorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    
    
    // TODO: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    
    // TODO: set layout
    func setLayout() {
        backgroundColor = .systemGray5
        addSubview(backgroundColorLabel)
        addSubview(backgroundColorValueView)

        NSLayoutConstraint.activate([
            backgroundColorLabel.widthAnchor.constraint(equalToConstant: 100),
            backgroundColorLabel.heightAnchor.constraint(equalToConstant: 50),
            backgroundColorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            backgroundColorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            backgroundColorValueView.topAnchor.constraint(equalTo: self.backgroundColorLabel.topAnchor, constant: 50),
            backgroundColorValueView.leadingAnchor.constraint(equalTo: self.backgroundColorLabel.leadingAnchor),
            backgroundColorValueView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            backgroundColorValueView.widthAnchor.constraint(equalToConstant: 100),
            backgroundColorValueView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
