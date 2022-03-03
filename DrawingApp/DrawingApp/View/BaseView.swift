//
//  BaseView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/03.
//

import UIKit

class BaseView: UIView {
    let id: String
    
    init(viewModel: ViewModel) {
        self.id = viewModel.id
        super.init(frame: viewModel.cgRect)
        
        if let colorMutableViewModel = viewModel as? ColorMutable {
            backgroundColor = colorMutableViewModel.uiColor
        }
        
        if let alphaMutableViewModel = viewModel as? AlphaMutable {
            alpha = alphaMutableViewModel.cgAlpha
        }
    }
    
    required init?(coder: NSCoder) {
        // No id when intialized without ViewModel
        self.id = ""
        super.init(coder: coder)
    }
}
