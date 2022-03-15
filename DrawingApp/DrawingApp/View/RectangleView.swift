//
//  RectangleView.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/15.
//

import Foundation
import UIKit

class RectangleView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
