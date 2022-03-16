//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class MainViewController: UIViewController{
    private var plane = Plane()
    private let rectFactory = RectangleFactory()
    private let rightAttributerView = RightAttributerView()
    private let imagePicker = UIImagePickerController()
    
    private var customUIViews = [RectValue : UIView]()
    private var panGestureExtraView: UIView?
    
    @IBOutlet weak var rectangleButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
        albumButton.layer.cornerRadius = 15
        
        imagePicker.delegate = self
        rightAttributerView.sliderDelegate = self
        rightAttributerView.stepperDelegate = self
        rightAttributerView.setViewsPositionMaxValue(maxX: rightAttributerView.frame.minX, maxY: rectangleButton.frame.minY)
        self.view.addSubview(rightAttributerView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        let dragGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragGesture))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        self.view.addGestureRecognizer(dragGestureRecognizer)
        
        addViewMakerButtonObserver()
        addGestureRecognizerObserver()
        addNoneTappedViewObserver()
    }
}


// MARK: - Use case: Make RectangleView

extension MainViewController{
    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleValue = rectFactory.makePosition(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
        plane.addValue(rectangle: rectangleValue)
    }
    
    @objc func addRectangleView(_ notification: Notification){
        guard let rectangleValue = notification.userInfo?[Plane.NotificationName.userInfoKey] as? Rectangle else { return }
        
        let rectangleView = CustomViewFactory.makeViewFrame(value: rectangleValue)
        rectangleView.backgroundColor = CustomViewFactory.setRectangleViewBackgroundColor(value: rectangleValue)
        rectangleView.restorationIdentifier = CustomViewFactory.setViewID(value: rectangleValue)
        
        self.view.addSubview(rectangleView)
        customUIViews[rectangleValue] = rectangleView
        
        os_log("%@", "\(rectangleValue.description)")
    }
}


// MARK: - Use case: Make ImageView

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func makeImage(_ sender: Any) {
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let imageValue = rectFactory.makePosition(image: MyImage(image: pickedImage), viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
            plane.addValue(image: imageValue)
        }

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addImageRectangleView(_ notification: Notification){
        guard let imageValue = notification.userInfo?[Plane.NotificationName.userInfoKey] as? Image else { return }
        
        let imageView = CustomViewFactory.makeViewFrame(value: imageValue)
        
        imageView.alpha = CustomViewFactory.setImageViewAlpha(value: imageValue)
        imageView.image = CustomViewFactory.setImageViewInnerImage(value: imageValue)
        imageView.restorationIdentifier = CustomViewFactory.setViewID(value: imageValue)
        
        self.view.addSubview(imageView)
        customUIViews[imageValue] = imageView
        
        os_log("%@", "\(imageValue.description)")
    }
}


// MARK: - Use case: Add observers

extension MainViewController{
    private func addViewMakerButtonObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(addRectangleView(_:)), name: Plane.NotificationName.makeRectangle, object: plane)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addImageRectangleView(_:)), name: Plane.NotificationName.makeImage, object: plane)
    }
    
    private func addGestureRecognizerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showTouchedCustomView(_:)), name: Plane.NotificationName.selectValue, object: plane)
    }
    
    private func addNoneTappedViewObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showNonTouchedView), name: Plane.NotificationName.noneSelect, object: plane)
    }
}


// MARK: - Use case: Click Rectangle / Image View

extension MainViewController {
    @objc func tapGesture(_ gesture: UITapGestureRecognizer){
        let touchPoint = gesture.location(in: self.view)
        plane.findValue(withX: touchPoint.x, withY: touchPoint.y)
        
        return
    }
    
    @objc func showTouchedCustomView(_ notification: Notification){
        guard let value = notification.userInfo?[Plane.NotificationName.userInfoKey] as? RectValue else{
            return
        }
        
        if let _ = plane.selectedValue{
            noneTouchedViewFrame()
        }
        
        displaySliderValue(selected: value)
        displayStepperValue(selected: value)
        touchedViewFrame(selected: value)
        plane.getSelectedValue(value: value)
    }
    
    @objc private func showNonTouchedView(){
        noneTouchedViewFrame()
        noneDisplaySliderValue()
        noneDisplayStepperValue()
    }
}
    
    
// MARK: - Use case: Show click Rectangle / Image View event

extension MainViewController{
    private func displaySliderValue<T: RectValue>(selected: T){
        if let rectangle = selected as? Rectangle{
            rightAttributerView.originSliderValue(red: Float(rectangle.color.red), green: Float(rectangle.color.green), blue: Float(rectangle.color.blue), alpha: Float(rectangle.alpha.showValue()))
            
            rightAttributerView.useColorSlider()
            rightAttributerView.useAlphaSlider()
            
        } else if let image = selected as? Image{
            rightAttributerView.originSliderValue(red: 0, green: 0, blue: 0, alpha: Float(image.alpha.showValue()))
            
            rightAttributerView.rockColorSlider()
            rightAttributerView.useAlphaSlider()
        }
    }
    
    private func displayStepperValue(selected: RectValue){
        rightAttributerView.originStepperValue(x: selected.point.x, y: selected.point.y, width: selected.size.width, height: selected.size.height)
    }
    
    private func noneDisplaySliderValue(){
        rightAttributerView.originSliderValue(red: 0, green: 0, blue: 0, alpha: 1)
        rightAttributerView.rockColorSlider()
        rightAttributerView.rockAlphaSlider()
    }
    
    private func noneDisplayStepperValue(){
        rightAttributerView.originStepperValue(x: 0, y: 0, width: 0, height: 0)
    }
    
    private func touchedViewFrame(selected: RectValue){
        guard let view = customUIViews[selected] else{
            return
        }
        
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.borderWidth = 3
    }
    
    private func noneTouchedViewFrame(){
        guard let value = plane.selectedValue else{
            return
        }
        let view = customUIViews[value]
        view?.layer.borderColor = .none
        view?.layer.borderWidth = 0
        
        plane.getSelectedValue(value: nil)
    }
}


// MARK: - Use case: Drag Rectangle / Image View

extension MainViewController {
    @objc func dragGesture(_ gesture: UIPanGestureRecognizer){
        let moveDistance = gesture.translation(in: self.view)
    
        switch gesture.state{
        case .began:
            let touchPoint = gesture.location(in: self.view)
            plane.findValue(withX: touchPoint.x, withY: touchPoint.y)
            makeExtraView()
        case .changed:
            moveExtraView(moveDistance: moveDistance)
            gesture.setTranslation(.zero, in: self.view)
        case .ended:
            changeViewPoint()
        default:
            return
        }
    }
    
    private func makeExtraView(){
        guard let value = plane.selectedValue, let view = customUIViews[value] else{
            return
        }
        
        panGestureExtraView = view.copyCustomView()
        
        guard let extraView = panGestureExtraView else{
            os_log("Can't copy CustomView")
            return
        }
        
        self.view.addSubview(extraView)
    }
    
    private func moveExtraView(moveDistance: CGPoint){
        guard let extraView = panGestureExtraView else{
            return
        }
        
        extraView.movingExtraViewCenterPosition(view: extraView, x: moveDistance.x, y: moveDistance.y)
    }
    
    private func changeViewPoint(){
        guard let extraView = panGestureExtraView, let selectValue = plane.selectedValue, let view = customUIViews[selectValue] else{
            return
        }
        
        if extraView.frame.maxX < self.rightAttributerView.frame.minX, extraView.frame.maxY < self.rectangleButton.frame.minY{
            view.changeOriginalViewCenterPositon(view: view, x: extraView.center.x, y: extraView.center.y)
            selectValue.changePoint(point: MyPoint(x: extraView.frame.origin.x, y: extraView.frame.origin.y))
        }
        
        extraView.removeFromSuperview()
        panGestureExtraView = nil
    }
}


// MARK: - Use case: Control RigthAttributerView's sliders

extension MainViewController: UIColorSliderDelegate{
    func alphaSliderDidMove() {
        changeRectangleAlpha()
        rightAttributerView.changeAlphaSliderView(text: "투명도 : \(String(format: "%.0f", rightAttributerView.alphaValue.showValue() * 10))")
    }
    
    func redSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Red : \(String(format: "%.0f", rightAttributerView.redValue))")
    }
    
    func greenSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Green : \(String(format: "%.0f", rightAttributerView.greenValue))")
    }
    
    func blueSliderDidMove() {
        changeRectangleColor()
        rightAttributerView.changeColorSliderValue(text: "Blue : \(String(format: "%.0f", rightAttributerView.blueValue))")
    }
    
    func changeRectangleColor(){
        guard let rectangle = plane.selectedValue as? Rectangle, let rectView = customUIViews[rectangle] else{
            return
        }
        
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        rectangle.changeColor(color: newColor)
        
        rectView.backgroundColor = UIColor(red: rectangle.color.redValue(), green: rectangle.color.greenValue(), blue: rectangle.color.blueValue(), alpha: rectangle.alpha.showValue())
    }
    
    func changeRectangleAlpha(){
        if let rectangle = plane.selectedValue as? Rectangle{
            let rectView = customUIViews[rectangle]
        
            rectangle.changeAlpha(alpha: rightAttributerView.alphaValue)
            rectView?.backgroundColor = rectView?.backgroundColor?.withAlphaComponent(rectangle.alpha.showValue())
            
        } else if let image = plane.selectedValue as? Image{
            let imageView = customUIViews[image]
        
            image.changeAlpha(alpha: rightAttributerView.alphaValue)
            imageView?.alpha = image.alpha.showValue()
        }
    }
}


// MARK: - Use case: Control RigthAttributerView's Steppers

extension MainViewController: StepperDelegate{
    func xPositionValueDidChange() {
        //
    }
    
    func yPositionValueDidChange() {
        //
    }
    
    func widthValueDidChange() {
        //
    }
    
    func heightValueDidChange() {
        //
    }
    
}
