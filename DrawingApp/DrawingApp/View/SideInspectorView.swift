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
    
    // TODO: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    
    // TODO: set layout
    func setLayout() {
        backgroundColor = .systemGray5
        addSubview(backgroundColorLabel)
        
        NSLayoutConstraint.activate([
            backgroundColorLabel.widthAnchor.constraint(equalToConstant: 100),
            backgroundColorLabel.heightAnchor.constraint(equalToConstant: 50),
            backgroundColorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            backgroundColorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }
}
