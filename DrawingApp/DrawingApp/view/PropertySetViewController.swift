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
    
    private func addNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(changedColorText), name: DrawingViewController.Notification.Event.changedColorText, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alphaButtonHidden), name: DrawingViewController.Notification.Event.alphaButtonHidden, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedRectangleUI), name: DrawingViewController.Notification.Event.updateSelectedRectangleUI, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedPhotoUI), name: DrawingViewController.Notification.Event.updateSelectedPhotoUI, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDeselectedUI), name: DrawingViewController.Notification.Event.updateDeselectedUI, object: nil)
    }
    
    @IBAction func colorChangeTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: PropertySetViewController.Notification.Event.propertyAction, object: self, userInfo: [PropertySetViewController.Notification.Key.action : PropertyViewAction.colorChangedTapped])
    }
    
    @IBAction func alphaPlusTapped(_ sender: Any) {
        NotificationCenter.default.post(name: PropertySetViewController.Notification.Event.propertyAction, object: self, userInfo: [PropertySetViewController.Notification.Key.action : PropertyViewAction.alphaPlusTapped])
    }
    
    @IBAction func alphaMinusTapped(_ sender: Any) {
        NotificationCenter.default.post(name: PropertySetViewController.Notification.Event.propertyAction, object: self, userInfo: [PropertySetViewController.Notification.Key.action : PropertyViewAction.alphaMinusTapped])
    }
    
    @objc private func changedColorText(_ notification: Foundation.Notification){
        guard let rectangle = notification.userInfo?[DrawingViewController.Notification.Key.rectangle] as? RectangleViewModelMutable else { return }
        setColorButtonRGBText(rectangleRGB: rectangle.getColorRGB())
    }
    
    @objc private func alphaButtonHidden(_ notification: Foundation.Notification){
        guard let customModel = notification.userInfo?[DrawingViewController.Notification.Key.customViewModel] as? CustomViewModelMutable else { return }
        alphaButtonIsHidden(alpha: customModel.getAlpha())
    }
    
    @objc private func updateSelectedRectangleUI(_ notification: Foundation.Notification){
        guard let rectangle = notification.userInfo?[DrawingViewController.Notification.Key.rectangle] as? RectangleViewModelMutable else {
            return
        }
        alphaButtonIsHidden(alpha: rectangle.getAlpha())
        setColorButtonRGBText(rectangleRGB: rectangle.getColorRGB())
        changeColorButtonIsHidden(customModel: rectangle)
    }
    
    @objc private func updateSelectedPhotoUI(_ notification: Foundation.Notification){
        guard let photo = notification.userInfo?[DrawingViewController.Notification.Key.photo] as? PhotoViewModelMutable else {
            return
        }
        alphaButtonIsHidden(alpha: photo.getAlpha())
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
        customModel is PhotoViewModelMutable ? (colorChangeButton.isHidden = true) : (colorChangeButton.isHidden = false)
    }
    
    @objc private func updateDeselectedUI(_ notification: Foundation.Notification){
        plusAlphaButton.isHidden = false
        minusAlphaButton.isHidden = false
        colorChangeButton.setTitle("color change", for: .normal)
        changeColorButtonIsHidden(customModel: notification)
    }
    
    enum PropertyViewAction{
        case colorChangedTapped
        case alphaPlusTapped
        case alphaMinusTapped
    }
    
    enum Notification{
        enum Event{
            static let propertyAction = Foundation.Notification.Name.init("propertyAction")
        }
        enum Key{
            case action
        }
    }
}

