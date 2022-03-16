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
    private var plane: PlaneModelsChangeable?
    private lazy var rectangleAddButton = RectangleAddButton(frame: CGRect(x: view.center.x - 100, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private lazy var imageAddButton = ImageAddButton(frame: CGRect(x: view.center.x, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private var customViews: [AnyHashable: CustomBaseView] = [:]
    private let notificationCenter = NotificationCenter.default
    private lazy var photoPickerDelegate = PhotoPickerDelegate()
    private lazy var photoPickerController = UIImagePickerController()
    
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
    
    func setRectangleChangeable(plane: PlaneModelsChangeable){
        self.plane = plane
    }
    
    private func addInputNotificationObserver(){
        notificationCenter.addObserver(self, selector: #selector(addRectangleView), name: Plane.Notification.Event.addedRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(addPhotoView), name: Plane.Notification.Event.addedPhoto, object: plane)
        notificationCenter.addObserver(self, selector: #selector(getImageFromDevice), name: PhotoPickerDelegate.Notification.Event.getPhotoFromDevice, object: photoPickerDelegate)
        notificationCenter.addObserver(self, selector: #selector(propertyAction), name: SplitViewController.Notification.Event.propertyAction, object: nil)
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
    
    @objc private func deselectedCustomView(_ notification: Notification){
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.updateDeselectedUI, object: self)
        //drawingDelegate?.drawingViewDidDeselect()
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
    
    @objc private func getImageFromDevice(_ notification: Notification){
        guard let imageData = notification.userInfo?[PhotoPickerDelegate.Notification.Key.photoData] as? Data else { return }
        plane?.addRandomPhotoViewModel(imageData: imageData)
    }
    
    @objc private func addRectangleView(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        let rectangleView = RectangleView(size: rectangle.getSize(), point: rectangle.getPoint())
        rectangleView.setRGBColor(rgb: rectangle.getColorRGB())
        rectangleView.setAlpha(alpha: rectangle.getAlpha())
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.changedColorText, object: self, userInfo: [SplitViewController.Notification.Key.rectangle : rectangle])
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.alphaButtonHidden, object: self, userInfo: [SplitViewController.Notification.Key.customViewEntity : rectangle])
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rectangleTappedGesture))
        rectangleView.addGestureRecognizer(viewTapGesture)
        customViews[rectangle] = rectangleView
        view.addSubview(rectangleView)
    }
    
    @objc private func addPhotoView(_ notification: Notification){
        guard let photo = notification.userInfo?[Plane.Notification.Key.photo] as? Photo else {
            return
        }
        let photoView = PhotoView(size: photo.size, point: photo.point)
        photoView.setImage(imageData: photo.getImageData())
        photoView.setAlpha(alpha: photo.getAlpha())
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoTappedGesture))
        photoView.addGestureRecognizer(viewTapGesture)
        customViews[photo] = photoView
        self.view.addSubview(photoView)
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.alphaButtonHidden, object: self, userInfo: [SplitViewController.Notification.Key.customViewEntity : photo])
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.updateSelectedPhotoUI, object: self, userInfo: [SplitViewController.Notification.Key.photo : photo])
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
    
    @objc private func selectedRectangle(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.updateSelectedRectangleUI, object: self, userInfo: [SplitViewController.Notification.Key.rectangle : rectangle])
    }
    
    @objc private func selectedPhoto(_ notification: Notification){
        guard let photo = notification.userInfo?[Plane.Notification.Key.photo] as? Photo else {
            return
        }
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.updateSelectedPhotoUI, object: self, userInfo: [SplitViewController.Notification.Key.photo : photo])
    }
    
    @objc private func rectangleColorChanged(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        guard let rectangleView = customViews[rectangle] as? RectangleView else { return }
        rectangleView.setRGBColor(rgb: rectangle.getColorRGB())
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.changedColorText, object: self, userInfo: [SplitViewController.Notification.Key.rectangle : rectangle])
    }
    
    @objc private func customViewAlphaChanged(_ notification: Notification){
        guard let customModel = notification.userInfo?[Plane.Notification.Key.customViewEntity] as? CustomViewModel else {
            return
        }
        customViews[customModel]?.setAlpha(alpha: customModel.alpha)
        NotificationCenter.default.post(name: SplitViewController.Notification.Event.alphaButtonHidden, object: self, userInfo: [SplitViewController.Notification.Key.customViewEntity : customModel])
    }
    
    private func plusViewAlpha(){
        plane?.plusCustomViewAlpha()
    }
    
    private func minusViewAlpha(){
        plane?.minusCustomViewAlpha()
    }
    
    @objc private func propertyAction(_ notification: Notification) {
        guard let action = notification.userInfo?[SplitViewController.Notification.Key.action] as? PropertyViewAction else { return }
        switch action{
        case .colorChangedTapped:
            plane?.changeRectangleRandomColor()
        case .alphaPlusTapped:
            plusViewAlpha()
        case .alphaMinusTapped:
            minusViewAlpha()
        }
    }
}
