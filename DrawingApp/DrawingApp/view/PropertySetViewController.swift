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
    private let notificationCenter = NotificationCenter.default
    private var observer: NSKeyValueObservation?
    
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
        addNotificationObservers()
    }
    
    func setPropertyDelegate(propertyAction: PropertyDelegate){
        self.propertyDelegate = propertyAction
    }
    
    private func addNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(changedColorText), name: SplitViewController.NotiEvent.changedColorText, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alphaButtonHidden), name: SplitViewController.NotiEvent.alphaButtonHidden, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedUI), name: SplitViewController.NotiEvent.updateSelectedUI, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDeselectedUI), name: SplitViewController.NotiEvent.updateDeselectedUI, object: nil)
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
    
    @objc private func changedColorText(_ notification: Notification){
        guard let rectangle = notification.userInfo?[PropertyNotificationKey.rectangle] as? Rectangle else { return }
        setColorButtonRGBText(rectangleRGB: rectangle.color)
    }
    
    @objc private func alphaButtonHidden(_ notification: Notification){
        guard let rectangle = notification.userInfo?[PropertyNotificationKey.rectangle] as? Rectangle else { return }
        alphaButtonIsHidden(alpha: rectangle.alpha)
    }
    
    @objc private func updateSelectedUI(_ notification: Notification){
        guard let rectangle = notification.userInfo?[PropertyNotificationKey.rectangle] as? Rectangle else { return }
        alphaButtonIsHidden(alpha: rectangle.alpha)
        setColorButtonRGBText(rectangleRGB: rectangle.color)
    }
    
    private func setColorButtonRGBText(rectangleRGB: ColorRGB) {
        colorChangeButton.setTitle(rectangleRGB.description, for: .normal)
    }
    
    private func alphaButtonIsHidden(alpha: Double){
        alpha <= 0.0 ? (minusAlphaButton.isHidden = true) : (minusAlphaButton.isHidden = false)
        alpha >= 1.0 ? (plusAlphaButton.isHidden = true) : (plusAlphaButton.isHidden = false)
    }
    
    @objc private func updateDeselectedUI(_ notification: Notification){
        plusAlphaButton.isHidden = false
        minusAlphaButton.isHidden = false
        colorChangeButton.setTitle("color change", for: .normal)
    }
}
