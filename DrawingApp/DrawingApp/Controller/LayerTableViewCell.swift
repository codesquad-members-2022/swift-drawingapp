//
//  LayerTableViewCell.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/15.
//

import UIKit

class LayerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let button = UIButton()
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if selected { self.backgroundColor = .yellow }

        // Configure the view for the selected state
    }

}
