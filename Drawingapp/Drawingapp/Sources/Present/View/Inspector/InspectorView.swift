//
//  inspectorView.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/01.
//

import Foundation
import UIKit

class InspectorView: BaseView {
    
    let itemStackView = UIStackView()
    let backgroundColorInfo = InspectorItemLabelView()
    let backgroundColorInfo1 = InspectorItemLabelView()
    
    func bind(plane: Plane) {
    }
    
    override func attribute() {
        super.attribute()
        self.backgroundColor = UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 1, alpha: 1)
        
        itemStackView.axis = .vertical
        
        backgroundColorInfo.title.text = "배경색"
    }
    
    override func layout() {
        super.layout()
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        self.addSubview(itemStackView)
        itemStackView.addArrangedSubview(backgroundColorInfo)
        itemStackView.addArrangedSubview(backgroundColorInfo1)
        
        itemStackView.translatesAutoresizingMaskIntoConstraints = false
        itemStackView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
        itemStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        itemStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        itemStackView.bottomAnchor.constraint(equalTo: backgroundColorInfo1.bottomAnchor).isActive = true
    }
}
