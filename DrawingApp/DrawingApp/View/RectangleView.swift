//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/09.
//

import UIKit

class RectangleView: UIView {
    
    //MARK: Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = color
    }
    
    //MARK: Configure Components
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
