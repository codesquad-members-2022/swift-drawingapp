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
        NotificationCenter.default.addObserver(self, selector: #selector(changedColorText), name: SplitViewController.Notification.Event.changedColorText, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alphaButtonHidden), name: SplitViewController.Notification.Event.alphaButtonHidden, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedRectangleUI), name: SplitViewController.Notification.Event.updateSelectedRectangleUI, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedPhotoUI), name: SplitViewController.Notification.Event.updateSelectedPhotoUI, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDeselectedUI), name: SplitViewController.Notification.Event.updateDeselectedUI, object: nil)
    }
    
    @IBAction func colorChangeTapped(_ sender: UIButton) {
        propertyDelegate?.propertyViewAction(action: .colorChangedTapped)
    }
    
    @IBAction func alphaPlusTapped(_ sender: Any) {
        propertyDelegate?.propertyViewAction(action: .alphaPlusTapped)
    }
    
    @IBAction func alphaMinusTapped(_ sender: Any) {
        propertyDelegate?.propertyViewAction(action: .alphaMinusTapped)
    }
    
    @objc private func changedColorText(_ notification: Notification){
        guard let rectangle = notification.userInfo?[SplitViewController.Notification.Key.rectangle] as? Rectangle else { return }
        setColorButtonRGBText(rectangleRGB: rectangle.getColorRGB())
    }
    
    @objc private func alphaButtonHidden(_ notification: Notification){
        guard let customModel = notification.userInfo?[SplitViewController.Notification.Key.customViewEntity] as? CustomViewModel else { return }
        alphaButtonIsHidden(alpha: customModel.alpha)
    }
    
    @objc private func updateSelectedRectangleUI(_ notification: Notification){
        guard let rectangle = notification.userInfo?[SplitViewController.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        alphaButtonIsHidden(alpha: rectangle.alpha)
        setColorButtonRGBText(rectangleRGB: rectangle.getColorRGB())
        changeColorButtonIsHidden(customModel: rectangle)
    }
    
    @objc private func updateSelectedPhotoUI(_ notification: Notification){
        guard let photo = notification.userInfo?[SplitViewController.Notification.Key.photo] as? Photo else {
            return
        }
        alphaButtonIsHidden(alpha: photo.alpha)
        changeColorButtonIsHidden(customModel: photo)
    }
    
    private func setColorButtonRGBText(rectangleRGB: ColorRGB) {
        colorChangeButton.setTitle(rectangleRGB.description, for: .normal)
    }
    
    private func alphaButtonIsHidden(alpha: Double){
        alpha <= 0.0 ? (minusAlphaButton.isHidden = true) : (minusAlphaButton.isHidden = false)
        alpha >= 1.0 ? (plusAlphaButton.isHidden = true) : (plusAlphaButton.isHidden = false)
    }
    
    private func changeColorButtonIsHidden<T>(customModel: T){
        let photoType: Photo.Type = Photo.self
        photoType == type(of: customModel) ? (colorChangeButton.isHidden = true) : (colorChangeButton.isHidden = false)
    }
    
    @objc private func updateDeselectedUI(_ notification: Notification){
        plusAlphaButton.isHidden = false
        minusAlphaButton.isHidden = false
        colorChangeButton.setTitle("color change", for: .normal)
        changeColorButtonIsHidden(customModel: notification)
    }
}
