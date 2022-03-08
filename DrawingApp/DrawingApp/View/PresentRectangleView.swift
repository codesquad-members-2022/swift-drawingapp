//
//  PresentRectangleView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/08.
//

import UIKit

class PresentRectangleView: UIView {
    
    //MARK: Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    //MARK: Configure Components
    
    func configureView() {
        self.backgroundColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
