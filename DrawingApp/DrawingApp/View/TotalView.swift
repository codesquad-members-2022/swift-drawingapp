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
    var sideInspectorViewDelegate: SideInspectorViewDelegate?
    var delegate: TotalViewDelegate? // VC에게 위임하기 위한 delegate 속성
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
        
        sideInspectorView.delegate = self // SideInspector의 delegate 역할
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


extension TotalView: SideInspectorViewDelegate {
    func sideInspectorView(_ sideInspectorView: SideInspectorView, buttonDidTapped: UIButton) {
        guard let rectangle = delegate?.totalViewDidTouched(self) else {
            return 
        }
        
        // 받은 직사각형을 CanvasView에 그려줘야함
        let myView = UIView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
        myView.backgroundColor = UIColor(hex: rectangle.backgroundColor.getHexValue())
        canvasView.addSubview(myView)
    }
}
