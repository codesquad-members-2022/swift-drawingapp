//
//  ViewController.swift
//  DrawingApp
//
//  Created by 김동준 on 2022/02/28.
//

import UIKit
import os

class DrawingViewController: UIViewController{
    private let logger = Logger()
    private var plane: PlaneModelManageable?
    private lazy var rectangleAddButton = RectangleAddButton(frame: CGRect(x: view.center.x - 100, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private lazy var imageAddButton = ImageAddButton(frame: CGRect(x: view.center.x, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private var customViews: [AnyHashable: CustomBaseViewSetable] = [:]
    private let notificationCenter = NotificationCenter.default
    private lazy var photoPickerDelegate = PhotoPickerDelegate()
    private lazy var photoPickerController = UIImagePickerController()
    private var customViewFactory: CustomViewMakeable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(rectangleAddButton)
        view.addSubview(imageAddButton)
        setRectangleButtonEvent()
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTappedGesture))
        view.addGestureRecognizer(viewTapGesture)
        addInputNotificationObserver()
        addOutputNotificationObserver()
    }
    
    func setRectangleChangeable(plane: PlaneModelManageable, customViewFactory: CustomViewMakeable){
        self.plane = plane
        self.customViewFactory = customViewFactory
    }
    
    private func addInputNotificationObserver(){
        notificationCenter.addObserver(self, selector: #selector(addRectangleViewToSubView), name: Plane.Notification.Event.addedRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(addPhotoViewToSubView), name: Plane.Notification.Event.addedPhoto, object: plane)
        notificationCenter.addObserver(self, selector: #selector(getImageFromDevice), name: PhotoPickerDelegate.Notification.Event.getPhotoFromDevice, object: photoPickerDelegate)
        notificationCenter.addObserver(self, selector: #selector(propertyAction), name: PropertySetViewController.Notification.Event.propertyAction, object: nil)
    }
    
    private func addOutputNotificationObserver(){
        notificationCenter.addObserver(self, selector: #selector(selectedRectangle), name: Plane.Notification.Event.selectedRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(selectedPhoto), name: Plane.Notification.Event.selectedPhoto, object: plane)
        notificationCenter.addObserver(self, selector: #selector(rectangleColorChanged), name: Plane.Notification.Event.changedRectangleColor, object: plane)
        notificationCenter.addObserver(self, selector: #selector(deselectedCustomView), name: Plane.Notification.Event.deselectedCustomView, object: plane)
        notificationCenter.addObserver(self, selector: #selector(customViewAlphaChanged), name: Plane.Notification.Event.updateCustomViewAlpha, object: plane)
    }
    
    @objc private func viewTappedGesture(){
        plane?.deSelectTargetCustomView()
    }
    
    @objc private func deselectedCustomView(_ notification: Foundation.Notification){
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.updateDeselectedUI, object: self)
    }
    
    private func setRectangleButtonEvent(){
        rectangleAddButton.addTarget(self, action: #selector(rectangleAddButtonTapped), for: .touchUpInside)
        imageAddButton.addTarget(self, action: #selector(imageAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func rectangleAddButtonTapped(sender: Any){
        plane?.addRandomRectnagleViewModel()
    }
    
    @objc func imageAddButtonTapped(sender: Any){
        setPhotoPickerState()
        present(photoPickerController, animated: true, completion: nil)
    }
    
    private func setPhotoPickerState(){
        photoPickerController.sourceType = .photoLibrary
        photoPickerController.allowsEditing = false
        photoPickerController.delegate = photoPickerDelegate
    }
    
    @objc private func getImageFromDevice(_ notification: Foundation.Notification){
        guard let imageData = notification.userInfo?[PhotoPickerDelegate.Notification.Key.photoData] as? Data else { return }
        plane?.addRandomPhotoViewModel(imageData: imageData)
    }
    
    @objc private func addRectangleViewToSubView(_ notification: Foundation.Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        guard let customView = customViewFactory?.makeRectangleView(size: rectangle.getSize(), point: rectangle.getPoint()) else {
            return
        }
        customView.setRGBColor(rgb: rectangle.getColorRGB())
        customView.setAlpha(alpha: rectangle.getAlpha())
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rectangleTappedGesture))
        customView.addGestureRecognizer(viewTapGesture)
        customViews[rectangle] = customView
        view.addSubview(customView)
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.changedColorText, object: self, userInfo: [DrawingViewController.Notification.Key.rectangle : rectangle])
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.alphaButtonHidden, object: self, userInfo: [DrawingViewController.Notification.Key.customViewModel : rectangle])
    }
    
    @objc private func addPhotoViewToSubView(_ notification: Foundation.Notification){
        guard let photo = notification.userInfo?[Plane.Notification.Key.photo] as? Photo else {
            return
        }
        guard let customView = customViewFactory?.makePhotoView(size: photo.getSize(), point: photo.getPoint()) else { return }
        customView.setImage(imageData: photo.getImageData())
        customView.setAlpha(alpha: photo.getAlpha())
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoTappedGesture))
        customView.addGestureRecognizer(viewTapGesture)
        customViews[photo] = customView
        view.addSubview(customView)
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.alphaButtonHidden, object: self, userInfo: [DrawingViewController.Notification.Key.customViewModel : photo])
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.updateSelectedPhotoUI, object: self, userInfo: [DrawingViewController.Notification.Key.photo : photo])
    }
    
    @objc func rectangleTappedGesture(sender: UITapGestureRecognizer){
        let touchedPoint = sender.location(in: self.view)
        let viewPoint = ViewPoint(x: Int(touchedPoint.x), y: Int(touchedPoint.y))
        plane?.selectTargetCustomView(point: viewPoint)
    }
    
    @objc func photoTappedGesture(sender: UITapGestureRecognizer){
        let touchedPoint = sender.location(in: self.view)
        let viewPoint = ViewPoint(x: Int(touchedPoint.x), y: Int(touchedPoint.y))
        plane?.selectTargetCustomView(point: viewPoint)
    }
    
    @objc private func selectedRectangle(_ notification: Foundation.Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.updateSelectedRectangleUI, object: self, userInfo: [DrawingViewController.Notification.Key.rectangle : rectangle])
    }
    
    @objc private func selectedPhoto(_ notification: Foundation.Notification){
        guard let photo = notification.userInfo?[Plane.Notification.Key.photo] as? Photo else {
            return
        }
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.updateSelectedPhotoUI, object: self, userInfo: [DrawingViewController.Notification.Key.photo : photo])
    }
    
    @objc private func rectangleColorChanged(_ notification: Foundation.Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        guard let rectangleView = customViews[rectangle] as? RectangleView else { return }
        rectangleView.setRGBColor(rgb: rectangle.getColorRGB())
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.changedColorText, object: self, userInfo: [DrawingViewController.Notification.Key.rectangle : rectangle])
    }
    
    @objc private func customViewAlphaChanged(_ notification: Foundation.Notification){
        guard let customModel = notification.userInfo?[Plane.Notification.Key.customViewEntity] as? CustomViewModel else {
            return
        }
        customViews[customModel]?.setAlpha(alpha: customModel.alpha)
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.alphaButtonHidden, object: self, userInfo: [DrawingViewController.Notification.Key.customViewModel : customModel])
    }
    
    private func plusViewAlpha(){
        plane?.plusCustomViewAlpha()
    }
    
    private func minusViewAlpha(){
        plane?.minusCustomViewAlpha()
    }
    
    @objc private func propertyAction(_ notification: Foundation.Notification) {
        guard let action = notification.userInfo?[PropertySetViewController.Notification.Key.action] as? PropertySetViewController.PropertyViewAction else { return }
        switch action{
        case .colorChangedTapped:
            plane?.changeRectangleRandomColor()
        case .alphaPlusTapped:
            plusViewAlpha()
        case .alphaMinusTapped:
            minusViewAlpha()
        }
    }
    
    enum Notification{
        enum Event{
            static let changedColorText = Foundation.Notification.Name.init("changedColorText")
            static let alphaButtonHidden = Foundation.Notification.Name.init("alphaButtonHidden")
            static let updateSelectedRectangleUI = Foundation.Notification.Name.init("updateSelectedUI")
            static let updateSelectedPhotoUI = Foundation.Notification.Name.init("updateSelectedPhotoUI")
            static let updateDeselectedUI = Foundation.Notification.Name.init("updateDeselectedUI")
        }
        enum Key{
            case rectangle
            case customViewModel
            case photo
        }
    }
   
}
