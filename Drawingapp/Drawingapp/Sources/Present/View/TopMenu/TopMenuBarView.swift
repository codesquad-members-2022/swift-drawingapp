//
//  TopMenuBarView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class TopMenuBarView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let makeSquare: TopMenuItemView = {
        let makeSquare = TopMenuItemView()
        makeSquare.backgroundColor = .clear
        makeSquare.icon.image = UIImage(named: "ic_square")
        makeSquare.translatesAutoresizingMaskIntoConstraints = false
        return makeSquare
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
//    func bind(plane: Plane) {
//        makeSquare.button.addAction(UIAction{ _ in
//            plane.action.makeSquareButtonTapped()
//        }, for: .touchUpInside)
//    }
    
    
    private func layout() {
        self.addSubview(stackView)
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
