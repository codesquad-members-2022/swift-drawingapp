//
//  InspectorItemView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorItemView: BaseView {
    let title = UILabel()
    let stackView = UIStackView()
    
    override init() {
        super.init()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
    }
    
    func bind() { }
    
    override func attribute() {
        super.attribute()
        title.textColor = .black
        stackView.axis = .vertical
    }
    
    override func layout() {
        super.layout()
        self.addSubview(stackView)
        stackView.addArrangedSubview(title)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
}
