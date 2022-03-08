//
//  InputView.swift
//  DrawingApp
//
//  Created by jsj on 2022/03/08.
//

import UIKit

class InputView: UIView {
    // MARK:- IBOutlets
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var backgroundColorHexTextField: UITextField!
    @IBOutlet weak var backgroundColorRGBTextField: UITextField!
    @IBOutlet weak var alphaTextField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    func loadView(with rect: Rectangle?) {
        guard let selectedRect = rect else {
            self.backgroundColorView.backgroundColor = .white
            self.alphaTextField.text = nil
            return
        }
        self.backgroundColorView.backgroundColor = UIColor(color: selectedRect.color)
        self.alphaTextField.text = "\(selectedRect.alpha)"
        self.backgroundColorRGBTextField.text = "rgb(\(selectedRect.color.red),\(selectedRect.color.green),\(selectedRect.color.blue))"
        let hexString = UIColor(color: selectedRect.color).toHexString()
        self.backgroundColorHexTextField.text = hexString
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
