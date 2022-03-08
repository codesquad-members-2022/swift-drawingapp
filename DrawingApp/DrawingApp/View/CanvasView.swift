//
//  BaseView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/03.
//

import UIKit

class CanvasView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Factory method using ViewModel
    static func create(from viewModel: ViewModel) -> CanvasView {
        let frame = CGRect(origin: viewModel.origin, size: viewModel.size)
        let canvasView = CanvasView(frame: frame)
        
        if let photo = viewModel as? Photo {
            canvasView.image = UIImage(data: photo.data)
        }
        
        if let colorMutableViewModel = viewModel as? ColorMutable {
            canvasView.backgroundColor = UIColor(with: colorMutableViewModel.color)
        }
        
        if let alphaMutableViewModel = viewModel as? AlphaMutable {
            canvasView.alpha = CGFloat(with: alphaMutableViewModel.alpha)
        }
        
        return canvasView
    }
    
    
    func createTemporary() -> CanvasView {
        let temporaryView = CanvasView(frame: self.frame)
        
        if let image = self.image {
            temporaryView.image = image
        }
        
        if let backgroundColor = self.backgroundColor {
            temporaryView.backgroundColor = backgroundColor
        }
        
        temporaryView.alpha = self.alpha * 0.5
        
        temporaryView.layer.shadowColor = UIColor.black.cgColor
        temporaryView.layer.shadowOpacity = 1
        temporaryView.layer.shadowOffset = .zero
        temporaryView.layer.shouldRasterize = true
        return temporaryView
    }
    
    
}
