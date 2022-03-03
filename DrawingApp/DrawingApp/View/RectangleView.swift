//
//  RectangleView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/03.
//

import UIKit

class RectangleView: UIView {
    init(viewModel: ViewModel) {
        super.init(frame: viewModel.cgRect)
        
        if let colorMutableViewModel = viewModel as? ColorMutable {
            backgroundColor = colorMutableViewModel.uiColor
        }
        
        if let alphaMutableViewModel = viewModel as? AlphaMutable {
            alpha = alphaMutableViewModel.cgAlpha
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
