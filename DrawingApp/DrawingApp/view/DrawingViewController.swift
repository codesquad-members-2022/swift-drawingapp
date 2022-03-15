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
    private var plane: CustomEntitiesChangeable?
    private lazy var rectangleAddButton = RectangleAddButton(frame: CGRect(x: view.center.x - 100, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private lazy var imageAddButton = ImageAddButton(frame: CGRect(x: view.center.x, y: view.frame.maxY - 144.0, width: 100, height: 100))
    private var drawingDelegate: DrawingDelegate?
    private var customViews: [String: CustomBaseView] = [:]
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
        addNotificationObserver()
    }
    
    func setDrawingDelegate(drawingDelegate: DrawingDelegate){
        self.drawingDelegate = drawingDelegate
    }
    
    func setRectangleChangeable(plane: CustomEntitiesChangeable){
        self.plane = plane
    }
    
    private func addNotificationObserver(){
        notificationCenter.addObserver(self, selector: #selector(addRectangleView), name: Plane.Notification.Event.addedRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(addPhotoView), name: Plane.Notification.Event.addedPhoto, object: plane)
        notificationCenter.addObserver(self, selector: #selector(rectangleColorChanged), name: Plane.Notification.Event.changedRectangleColor, object: plane)
        notificationCenter.addObserver(self, selector: #selector(selectedRectangle), name: Plane.Notification.Event.selectedRectangle, object: plane)
        notificationCenter.addObserver(self, selector: #selector(selectedPhoto), name: Plane.Notification.Event.selectedPhoto, object: plane)
        notificationCenter.addObserver(self, selector: #selector(deselectedCustomView), name: Plane.Notification.Event.deselectedCustomView, object: plane)
        notificationCenter.addObserver(self, selector: #selector(customViewAlphaChanged), name: Plane.Notification.Event.updateCustomViewAlpha, object: plane)
        notificationCenter.addObserver(self, selector: #selector(propertyAction), name: SplitViewController.Notification.Event.propertyAction, object: nil)
        notificationCenter.addObserver(self, selector: #selector(getImageFromDevice), name: PhotoPickerDelegate.Notification.Event.getPhotoFromDevice, object: photoPickerDelegate)
    }
    
    @objc private func viewTappedGesture(){
        plane?.deSelectTargetCustomView()
    }
    
    @objc private func deselectedCustomView(_ notification: Notification){
        drawingDelegate?.drawingViewDidDeselect()
    }
    
    private func setRectangleButtonEvent(){
        rectangleAddButton.addTarget(self, action: #selector(rectangleAddButtonTapped), for: .touchUpInside)
        imageAddButton.addTarget(self, action: #selector(imageAddButtonTapped), for: .touchUpInside)
    }
    
    @objc func rectangleAddButtonTapped(sender: Any){
        plane?.addRandomRectnagle()
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
        plane?.addRandomPhoto(imageData: imageData)
    }
    
    @objc private func addRectangleView(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        let rectangleView = RectangleView(size: rectangle.size, point: rectangle.point)
        rectangleView.setRGBColor(rgb: rectangle.color)
        rectangleView.setAlpha(alpha: rectangle.alpha)
        drawingDelegate?.drawingViewDidChangeColor(rectangle: rectangle)
        drawingDelegate?.drawingViewDidUpdateAlpha(customModel: rectangle)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rectangleTappedGesture))
        rectangleView.addGestureRecognizer(viewTapGesture)
        customViews[rectangle.uniqueId] = rectangleView
        view.addSubview(rectangleView)
    }
    
    @objc private func addPhotoView(_ notification: Notification){
        guard let photo = notification.userInfo?[Plane.Notification.Key.photo] as? Photo else {
            return
        }
        let photoView = PhotoView(size: photo.size, point: photo.point)
        
        photoView.setImage(imageData: photo.imageData)
        photoView.setAlpha(alpha: photo.alpha)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoTappedGesture))
        photoView.addGestureRecognizer(viewTapGesture)
        customViews[photo.uniqueId] = photoView
        self.view.addSubview(photoView)
        drawingDelegate?.drawingViewDidUpdateAlpha(customModel: photo)
        drawingDelegate?.drawingViewDidSelectedPhoto(photo: photo)
    }
    
    @objc func rectangleTappedGesture(sender: UITapGestureRecognizer){
        guard let touchedView = sender.view as? RectangleView else { return }
        let point = ViewPoint(x: Int(touchedView.frame.origin.x), y: Int(touchedView.frame.origin.y))
        plane?.selectTargetCustomView(point: point)
    }
    
    @objc func photoTappedGesture(sender: UITapGestureRecognizer){
        guard let touchedView = sender.view as? PhotoView else { return }
        let point = ViewPoint(x: Int(touchedView.frame.origin.x), y: Int(touchedView.frame.origin.y))
        plane?.selectTargetCustomView(point: point)
    }
    
    @objc private func selectedRectangle(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        drawingDelegate?.drawingViewDidSelecteRectangle(rectangle: rectangle)
    }
    
    @objc private func selectedPhoto(_ notification: Notification){
        guard let photo = notification.userInfo?[Plane.Notification.Key.photo] as? Photo else {
            return
        }
        drawingDelegate?.drawingViewDidSelectedPhoto(photo: photo)
    }
    
    @objc private func rectangleColorChanged(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.Notification.Key.rectangle] as? Rectangle else {
            return
        }
        guard let rectangleView = customViews[rectangle.uniqueId] as? RectangleView else { return }
        rectangleView.setRGBColor(rgb: rectangle.color)
        drawingDelegate?.drawingViewDidChangeColor(rectangle: rectangle)
    }
    
    @objc private func customViewAlphaChanged(_ notification: Notification){
        guard let customModel = notification.userInfo?[Plane.Notification.Key.customViewEntity] as? CustomViewEntity else {
            return
        }
        customViews[customModel.uniqueId]?.setAlpha(alpha: customModel.alpha)
        drawingDelegate?.drawingViewDidUpdateAlpha(customModel: customModel)
    }
    
    private func plusViewAlpha(){
        plane?.plusCustomViewAlpha()
    }
    
    private func minusViewAlpha(){
        plane?.CustomViewAlpha()
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
