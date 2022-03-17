//
//  RightView.swift
//  DrawingApp
//
//  Created by Jihee hwang on 2022/03/14.
//

import UIKit

class Panel: UIView {

    var delegate: PanelDelegate?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadXib()
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
    
    @IBAction func backgroundColor(_ sender: UIButton) {
        delegate?.didpressColorChangeButton()
    }
    
    @IBAction func changAlpha(_ sender: Any) {
        delegate?.didMoveSlider()
    }
    
    @IBAction func createRectangle(_ sender: UIButton) {
        delegate?.didpressCreateRectangleButton()
    }
}
