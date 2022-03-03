//
//  InspectorItemView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorItemView: UIView {
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
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
        self.addSubview(stackView)
        stackView.addArrangedSubview(title)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
}
