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
        let frame = Converter.toCGRect(origin: viewModel.origin, size: viewModel.size)
        super.init(frame: frame)
        
        if let colorMutableViewModel = viewModel as? ColorMutable {
            backgroundColor = Converter.toUIColor(colorMutableViewModel.color)
        }
        
        if let alphaMutableViewModel = viewModel as? AlphaMutable {
            alpha = Converter.toCGFloat(alphaMutableViewModel.alpha)
        }
    }
    
    required init?(coder: NSCoder) {
        // No id when intialized without ViewModel
        self.id = ""
        super.init(coder: coder)
    }
}
