//
//  InspectorTwoUpDownView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation
import UIKit

class InspectorTwoUpDownView: InspectorItemView{
    let firstView: InspectorUpDownView = {
        let upDownView = InspectorUpDownView()
        upDownView.translatesAutoresizingMaskIntoConstraints = false
        return upDownView
    }()
    
    let secondView: InspectorUpDownView = {
        let upDownView = InspectorUpDownView()
        upDownView.translatesAutoresizingMaskIntoConstraints = false
        return upDownView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    private func layout() {
        self.stackView.addArrangedSubview(firstView)
        self.stackView.addArrangedSubview(secondView)
        
        firstView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        secondView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}
