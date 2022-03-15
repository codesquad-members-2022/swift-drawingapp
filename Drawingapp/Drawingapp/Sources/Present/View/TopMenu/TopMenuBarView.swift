//
//  TopMenuBarView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

protocol TopMenuBarDelegate {
    func makeRectangleTapped()
    func makePhotoTapped()
    func makeLabelTapped()
}

class TopMenuBarView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let makeRectangle: TopMenuItemView = {
        let itemView = TopMenuItemView()
        itemView.backgroundColor = .clear
        itemView.setIcon(name: "ic_rectangle")
        itemView.translatesAutoresizingMaskIntoConstraints = false
        return itemView
    }()
    
    private let makePhoto: TopMenuItemView = {
        let itemView = TopMenuItemView()
        itemView.backgroundColor = .clear
        itemView.setIcon(name: "ic_photo")
        itemView.translatesAutoresizingMaskIntoConstraints = false
        return itemView
    }()
    
    private let makeLabel: TopMenuItemView = {
        let itemView = TopMenuItemView()
        itemView.backgroundColor = .clear
        itemView.setIcon(name: "ic_text")
        itemView.translatesAutoresizingMaskIntoConstraints = false
        return itemView
    }()
    
    private var items: [TopMenuItemView] {
        [makeRectangle, makePhoto, makeLabel]
    }
    
    var delegate: TopMenuBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
        layout()
    }
    
    private func bind() {
        makeRectangle.bind {
            self.delegate?.makeRectangleTapped()
        }
        
        makePhoto.bind {
            self.delegate?.makePhotoTapped()
        }
    
        makeLabel.bind {
            self.delegate?.makeLabelTapped()
        }
    }
    
    private func layout() {
        self.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        items.forEach {
            stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
}
