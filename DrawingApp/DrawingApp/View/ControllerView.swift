//
//  ControllerView.swift
//  DrawingApp
//
//  Created by 최예주 on 2022/03/10.
//

import UIKit

class ControllerView: UIView {


    override init(frame: CGRect){
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        customInit()
    }
    
    
    func customInit() {
            if let view = Bundle.main.loadNibNamed("ControllerView", owner: self, options: nil)?.first as? UIView {
                view.frame = self.bounds
                addSubview(view)
            }
        }
}
