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
    private lazy var photoPickerController = UIImagePickerController()
    private var customViewFactory: CustomViewMakeable?
    private lazy var photoPickerDelegate = PhotoPickerDelegate(imageDataSendable: self)
    
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

    @objc private func addRectangleViewToSubView(_ notification: Foundation.Notification){
        guard let rectangleViewModel = notification.userInfo?[Plane.Notification.Key.rectangle] as? RectangleViewModelMutable else {
            return
        }
        guard let customView = customViewFactory?.makeRectangleView(size: rectangleViewModel.getSize(), point: rectangleViewModel.getPoint()) else {
            return
        }
        setRectangleViewColor(customView: customView, rectangleModel: rectangleViewModel)
        setViewAlpha(customView: customView, customViewModel: rectangleViewModel)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rectangleTappedGesture))
        customView.addGestureRecognizer(viewTapGesture)
        if let rectangle = rectangleViewModel as? Rectangle {
            customViews[rectangle] = customView
        }
        view.addSubview(customView)
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.updateSelectedRectangleUI, object: self, userInfo: [DrawingViewController.Notification.Key.rectangle : rectangleViewModel])
    }
    
    func setViewAlpha(customView: CustomBaseViewSetable, customViewModel: CustomViewModelMutable){
        customView.setAlpha(alpha: customViewModel.getAlpha())
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.changedAlpha, object: self, userInfo: [DrawingViewController.Notification.Key.customViewModel : customViewModel])
    }
    
    func setRectangleViewColor(customView: RectangleViewSetable, rectangleModel: RectangleViewModelMutable){
        customView.setRGBColor(rgb: rectangleModel.getColorRGB())
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.changedRectangleColor, object: self, userInfo: [DrawingViewController.Notification.Key.rectangle : rectangleModel])
    }
    
    @objc private func addPhotoViewToSubView(_ notification: Foundation.Notification){
        guard let photoViewModel = notification.userInfo?[Plane.Notification.Key.photo] as? PhotoViewModelMutable else {
            return
        }
        guard let customView = customViewFactory?.makePhotoView(size: photoViewModel.getSize(), point: photoViewModel.getPoint()) else { return }
        customView.setImage(imageData: photoViewModel.getImageData())
        setViewAlpha(customView: customView, customViewModel: photoViewModel)
        let viewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(photoTappedGesture))
        customView.addGestureRecognizer(viewTapGesture)
        if let photo = photoViewModel as? Photo{
            customViews[photo] = customView
        }
        view.addSubview(customView)
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.updateSelectedPhotoUI, object: self, userInfo: [DrawingViewController.Notification.Key.photo : photoViewModel])
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
        guard let rectangleViewModel = notification.userInfo?[Plane.Notification.Key.rectangle] as? RectangleViewModelMutable else {
            return
        }
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.updateSelectedRectangleUI, object: self, userInfo: [DrawingViewController.Notification.Key.rectangle : rectangleViewModel])
    }
    
    @objc private func selectedPhoto(_ notification: Foundation.Notification){
        guard let photoViewModel = notification.userInfo?[Plane.Notification.Key.photo] as? PhotoViewModelMutable else {
            return
        }
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.updateSelectedPhotoUI, object: self, userInfo: [DrawingViewController.Notification.Key.photo : photoViewModel])
    }
    
    @objc private func rectangleColorChanged(_ notification: Foundation.Notification){
        guard let rectangleViewModel = notification.userInfo?[Plane.Notification.Key.rectangle] as? RectangleViewModelMutable else {
            return
        }
        if let rectangle = rectangleViewModel as? Rectangle{
            guard let rectangleView = customViews[rectangle] as? RectangleView else { return }
            rectangleView.setRGBColor(rgb: rectangleViewModel.getColorRGB())
        }
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.changedRectangleColor, object: self, userInfo: [DrawingViewController.Notification.Key.rectangle : rectangleViewModel])
    }
    
    @objc private func customViewAlphaChanged(_ notification: Foundation.Notification){
        guard let customViewModelMutable = notification.userInfo?[Plane.Notification.Key.customViewModel] as? CustomViewModelMutable else {
            return
        }
        if let customModel = customViewModelMutable as? CustomViewModel{
            customViews[customModel]?.setAlpha(alpha: customViewModelMutable.getAlpha())
        }
        NotificationCenter.default.post(name: DrawingViewController.Notification.Event.changedAlpha, object: self, userInfo: [DrawingViewController.Notification.Key.customViewModel : customViewModelMutable])
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
            static let changedRectangleColor = Foundation.Notification.Name.init("changedColorText")
            static let changedAlpha = Foundation.Notification.Name.init("alphaButtonHidden")
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
extension DrawingViewController: ImageDataSendable{
    func sendImageData(imageData: Data){
       plane?.addRandomPhotoViewModel(imageData: imageData)
    }
}
protocol ImageDataSendable{
    func sendImageData(imageData: Data)
}
