//
//  RightView.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/14.
//

import UIKit


//@IBDesignable
class RightView: UIView {

    @IBOutlet weak var rightViewBackground: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    private func loadXib() {
        let identifier = String(describing: type(of: self))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        guard let inputView = nibs?.first as? UIView else {
            return
        }
        inputView.frame = self.bounds
        self.addSubview(inputView)
    }
    
}
