//
//  InspectorTwoUpDownView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/11.
//

import Foundation
import UIKit

class InspectorTwoUpDownView: InspectorItemView{
    private let firstView: InspectorUpDownView = {
        let upDownView = InspectorUpDownView()
        upDownView.translatesAutoresizingMaskIntoConstraints = false
        return upDownView
    }()
    
    private let secondView: InspectorUpDownView = {
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
    
    func bind(action: @escaping (ViewType, ButtonType) -> Void) {
        firstView.upButton.addAction(UIAction{ _ in
            action(.first, .up)
        }, for: .touchUpInside)
        
        firstView.downButton.addAction(UIAction{ _ in
            action(.first, .down)
        }, for: .touchUpInside)
        
        secondView.upButton.addAction(UIAction{ _ in
            action(.second, .up)
        }, for: .touchUpInside)
        
        secondView.downButton.addAction(UIAction{ _ in
            action(.second, .down)
        }, for: .touchUpInside)
    }
    
    func setTitles(firstTitle: String, secondTitle: String) {
        firstView.name.text = firstTitle
        secondView.name.text = secondTitle
    }
    
    func setValues(firstValue: String, secondValue: String) {
        firstView.value.text = firstValue
        secondView.value.text = secondValue
    }
}

extension InspectorTwoUpDownView {
    enum ViewType {
        case first, second
    }
    
    enum ButtonType {
        case up, down
    }
}
                                     
                                     
