//
//  PropertySetViewController.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/03/03.
//

import Foundation
import UIKit

class PropertySetViewController: UIViewController{
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var colorChangeButton: UIButton!
    @IBOutlet weak var alphaLabel: UILabel!
    @IBOutlet weak var plusAlphaButton: UIButton!
    @IBOutlet weak var minusAlphaButton: UIButton!
    private var propertyDelegate: PropertyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundLabel.text = "배경색"
        backgroundLabel.sizeToFit()
        alphaLabel.text = "투명도"
        alphaLabel.sizeToFit()
        colorChangeButton.setTitle("color change", for: .normal)
        colorChangeButton.backgroundColor = .systemGray5
        plusAlphaButton.setTitle("+", for: .normal)
        plusAlphaButton.backgroundColor = .systemGray5
        minusAlphaButton.setTitle("-", for: .normal)
        minusAlphaButton.backgroundColor = .systemGray5
    }
    
    func setPropertyDelegate(propertyAction: PropertyDelegate){
        self.propertyDelegate = propertyAction
    }
    
    @IBAction func colorChangeTapped(_ sender: UIButton) {
        propertyDelegate?.propertyAction(action: .colorChangedTapped)
    }
    
    @IBAction func alphaPlusTapped(_ sender: Any) {
        propertyDelegate?.propertyAction(action: .alphaPlusTapped)
    }
    
    @IBAction func alphaMinusTapped(_ sender: Any) {
        propertyDelegate?.propertyAction(action: .alphaMinusTapped)
    }
    
    func changedColor(rectangleRGB: ColorRGB) {
        colorChangeButton.setTitle(rectangleRGB.description, for: .normal)
    }
    
    func alphaButtonIsHidden(alpha: Double){
        alpha <= 0.0 ? (minusAlphaButton.isHidden = true) : (minusAlphaButton.isHidden = false)
        alpha >= 1.0 ? (plusAlphaButton.isHidden = true) : (plusAlphaButton.isHidden = false)
    }
    
    func updateSelectedUI(alpha: Double, rectangleRGB: ColorRGB){
        alphaButtonIsHidden(alpha: alpha)
        changedColor(rectangleRGB: rectangleRGB)
    }
    
    func updateDeselectedUI(){
        plusAlphaButton.isHidden = false
        minusAlphaButton.isHidden = false
        colorChangeButton.setTitle("color change", for: .normal)
    }
}
