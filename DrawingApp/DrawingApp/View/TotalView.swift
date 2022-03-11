//
//  TotalView.swift
//  DrawingApp
//
//  Created by 안상희 on 2022/03/11.
//

import Foundation
import UIKit

/// CanvasView + SideInpsectorView
class TotalView: UIView {
    let canvasView: CanvasView = {
        let view = CanvasView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sideInspectorView: SideInspectorView = {
        let view = SideInspectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setLayout()
    }
    
    func setLayout() {
        addSubview(canvasView)
        addSubview(sideInspectorView)
        
        NSLayoutConstraint.activate([
            sideInspectorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            sideInspectorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            sideInspectorView.widthAnchor.constraint(equalToConstant: 200),
            sideInspectorView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            canvasView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            canvasView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            canvasView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            canvasView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200)
        ])
    }
}
