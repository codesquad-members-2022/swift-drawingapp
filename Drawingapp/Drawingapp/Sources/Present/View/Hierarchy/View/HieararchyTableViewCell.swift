//
//  HieararchyTableViewCell.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/12.
//

import Foundation
import UIKit

class HieararchyTableViewCell: UITableViewCell {
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        attribute()
        layout()
    }
    
    private func attribute() {
        self.backgroundColor = .clear
    }
    
    private func layout() {
        self.addSubview(icon)
        self.addSubview(name)
        
        icon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        name.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        name.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    func setView(model: DrawingModel) {
        switch model {
        case _ as RectangleModel:
            icon.image = UIImage(named: "ic_square")
            name.text = "사각형 뷰"
        case _ as PhotoModel:
            icon.image = UIImage(named: "ic_photo")
            name.text = "사진 뷰"
        case _ as LabelModel:
            icon.image = UIImage(named: "ic_text")
            name.text = "라벨 뷰"
        default:
            return
        }
    }
}
