//
//  BaseView.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/03.
//

import UIKit

extension UIImageView {
    static func create(from viewModel: ViewModel) -> UIImageView? {
        let frame = CGRect(origin: viewModel.origin, size: viewModel.size)
        let view = UIImageView(frame: frame)
        
        if let photo = viewModel as? Photo {
            view.image = UIImage(data: photo.data)
        }
        
        if let colorMutable = viewModel as? ColorMutable {
            view.backgroundColor = UIColor(with: colorMutable.color)
        }
        
        if let alphaMuatable = viewModel as? AlphaMutable {
            view.alpha = CGFloat(with: alphaMuatable.alpha)
        }
        
        return view
    }
    
    func clone() -> UIImageView {
        let clone = UIImageView(frame: self.frame)
        
        if let image = self.image {
            clone.image = image
        }
        
        if let backgroundColor = self.backgroundColor {
            clone.backgroundColor = backgroundColor
        }
        
        applyCloneEffect(clone)
        
        return clone
    }
    
    private func applyCloneEffect(_ clone: UIImageView) {
        clone.alpha = self.alpha * 0.5
        
        clone.layer.shadowColor = UIColor.black.cgColor
        clone.layer.shadowOpacity = 1
        clone.layer.shadowOffset = .zero
        clone.layer.shouldRasterize = true
    }
}
