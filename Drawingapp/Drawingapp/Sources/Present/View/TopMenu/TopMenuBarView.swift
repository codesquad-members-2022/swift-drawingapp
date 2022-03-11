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
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let makeRectangle: TopMenuItemView = {
        let itemView = TopMenuItemView()
        itemView.backgroundColor = .clear
        itemView.icon.image = UIImage(named: "ic_square")
        itemView.translatesAutoresizingMaskIntoConstraints = false
        return itemView
    }()
    
    let makePhoto: TopMenuItemView = {
        let itemView = TopMenuItemView()
        itemView.backgroundColor = .clear
        itemView.icon.image = UIImage(named: "ic_photo")
        itemView.translatesAutoresizingMaskIntoConstraints = false
        return itemView
    }()
    
    let makeLabel: TopMenuItemView = {
        let itemView = TopMenuItemView()
        itemView.backgroundColor = .clear
        itemView.icon.image = UIImage(named: "ic_text")
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
        makeRectangle.button.addAction(UIAction{ _ in
            self.delegate?.makeRectangleTapped()
        }, for: .touchUpInside)
        
        makePhoto.button.addAction(UIAction{ _ in
            self.delegate?.makePhotoTapped()
        }, for: .touchUpInside)
        
        makeLabel.button.addAction(UIAction{ _ in
            self.delegate?.makeLabelTapped()
        }, for: .touchUpInside)
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
