//
//  InspectorUpDownView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/10.
//

import Foundation
import UIKit

class InspectorUpDownView: UIView {
    private let name: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let value: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let upButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let downButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        attribute()
        layout()
    }
    
    private func attribute() {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .clear
    }
    
    private func layout() {
        
    }
}
