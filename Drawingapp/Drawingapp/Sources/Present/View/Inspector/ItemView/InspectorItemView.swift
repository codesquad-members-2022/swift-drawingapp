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
    
    override func attribute() {
        super.attribute()
        title.text = "제목 출력 부분"
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
}
