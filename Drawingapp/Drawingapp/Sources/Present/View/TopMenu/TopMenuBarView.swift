//
//  TopMenuBarView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class TopMenuBarView: BaseView {
    let stackView = UIStackView()
    let makeSquare = TopMenuItemView()
    
    func bind(plane: Plane) {
        makeSquare.button.addAction(UIAction{ _ in
            plane.action.makeSquareButtonTapped()
        }, for: .touchUpInside)
    }
    
    override func attribute() {
        super.attribute()
        self.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        self.layer.cornerRadius = 5
        
        stackView.spacing = 5
        
        makeSquare.icon.image = UIImage(named: "ic_square")
    }
    
    override func layout() {
        super.layout()
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        stackView.addArrangedSubview(makeSquare)
        makeSquare.translatesAutoresizingMaskIntoConstraints = false
        makeSquare.widthAnchor.constraint(equalToConstant: 50).isActive = true
        makeSquare.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
