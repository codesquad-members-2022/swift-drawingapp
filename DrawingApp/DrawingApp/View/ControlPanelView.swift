//
//  ControlPanelView.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/08.
//

import UIKit

protocol ControlPanelViewDelegate {
    
}

class ControlPanelView: UIView {
    var delegate: ControlPanelViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
