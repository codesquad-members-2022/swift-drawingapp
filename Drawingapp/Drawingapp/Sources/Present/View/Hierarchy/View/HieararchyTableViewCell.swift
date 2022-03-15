//
//  HieararchyTableViewCell.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/12.
//

import Foundation
import UIKit

protocol HieararchyCellDelegate {
    func selectCell(_ cell: HieararchyTableViewCell)
    func move(to: HierarchyView.MoveTo, cell: HieararchyTableViewCell)
}

class HieararchyTableViewCell: UITableViewCell {
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var delegate: HieararchyCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bind()
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        bind()
        attribute()
        layout()
    }
    
    private func bind() {
        let cellMenus: [UIAction] = [
            UIAction(title: "맨 뒤로 보내기", image: nil, handler: { _ in
                self.delegate?.move(to: .last, cell: self)
            }),
            UIAction(title: "뒤로 보내기", image: nil, handler: { _ in
                self.delegate?.move(to: .back, cell: self)
            }),
            UIAction(title: "맨 앞으로 보내기", image: nil, handler: { _ in
                self.delegate?.move(to: .front, cell: self)
            }),
            UIAction(title: "앞으로 보내기", image: nil, handler: { _ in
                self.delegate?.move(to: .forward, cell: self)
            })
        ]
        
        button.menu = UIMenu(title: "추가메뉴", image: nil, identifier: nil, options: .displayInline, children: cellMenus)
        
        button.addAction(UIAction{ _ in
            self.delegate?.selectCell(self)
        }, for: .touchUpInside)
    }
    
    private func attribute() {
        self.backgroundColor = .clear
    }
    
    private func layout() {
        self.addSubview(icon)
        self.addSubview(name)
        self.contentView.addSubview(button)
        
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        name.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        name.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        button.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setView(model: DrawingModel) {
        guard let viewData = model as? Viewable else {
            return
        }
        icon.image = UIImage(named: viewData.iconName)
        name.text = viewData.displayName
    }
}
