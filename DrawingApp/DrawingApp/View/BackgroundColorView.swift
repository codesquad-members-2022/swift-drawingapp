//
//  BackgroundColorView.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/09.
//

import Foundation
import UIKit

/// 배경 색상을 나타내는 뷰
class BackgroundColorView: UIView {
    /// 배경 색상 값을 16진수로 나타내는 라벨
    let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "#000000"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }

    func setLayout() {
        addSubview(colorLabel)
        
        NSLayoutConstraint.activate([
            colorLabel.widthAnchor.constraint(equalToConstant: 100),
            colorLabel.heightAnchor.constraint(equalToConstant: 50),
            colorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            colorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
