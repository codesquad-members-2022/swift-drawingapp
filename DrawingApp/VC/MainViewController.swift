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
    
    private var rectangleUIViews = [Rectangle : RectangleView]()
    private var imageUIViews = [Image : ImageView]()
    private var selectedValue: RectValue?
    
    private var panGestureExtraView: RectangleView?
    private var panGestureExtraImageView: ImageView?
    
    @IBOutlet weak var rectangleButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rectangleButton.layer.cornerRadius = 15
        albumButton.layer.cornerRadius = 15
        
        imagePicker.delegate = self
        rightAttributerView.delegate = self
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
        guard let rectangleValue = notification.userInfo?[Plane.NotificationName.userInfoKeyRectangle] as? Rectangle else { return }
        
        let rectangleView = RectangleView(frame: CGRect(x: rectangleValue.point.x, y: rectangleValue.point.y, width: rectangleValue.size.width, height: rectangleValue.size.height))
        rectangleView.backgroundColor = UIColor(red: rectangleValue.color.redValue(), green: rectangleValue.color.greenValue(), blue: rectangleValue.color.blueValue(), alpha: rectangleValue.alpha.showValue())
        rectangleView.restorationIdentifier = rectangleValue.id
        
        self.view.addSubview(rectangleView)
        rectangleUIViews[rectangleValue] = rectangleView
        
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
        guard let imageValue = notification.userInfo?[Plane.NotificationName.userInfoKeyImage] as? Image else { return }
        
        let imageView = ImageView(frame: CGRect(x: imageValue.point.x, y: imageValue.point.y, width: imageValue.size.width, height: imageValue.size.height))
        
        imageView.alpha = imageValue.alpha.showValue()
        imageView.image = imageValue.image.image
        
        self.view.addSubview(imageView)
        imageUIViews[imageValue] = imageView
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(showRectangleTouchedView(_:)), name: Plane.NotificationName.selectRectangle, object: plane)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showImageTouchedView(_:)), name: Plane.NotificationName.selectImage, object: plane)
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
    
    @objc func showRectangleTouchedView(_ notification: Notification){
        guard let rectangle = notification.userInfo?[Plane.NotificationName.userInfoKeyRectangle] as? Rectangle else{
            return
        }
        
        if let _ = selectedValue{
            noneTouchedViewFrame()
        }
        
        displaySliderValue(selected: rectangle)
        touchedViewFrame(selected: rectangle)
        selectedValue = rectangle
    }
    
    @objc func showImageTouchedView(_ notification: Notification){
        guard let image = notification.userInfo?[Plane.NotificationName.userInfoKeyImage] as? Image else{
            return
        }
        
        if let _ = selectedValue{
            noneTouchedViewFrame()
        }
        
        displaySliderValue(selected: image)
        touchedViewFrame(selected: image)
        selectedValue = image
    }
    
    @objc private func showNonTouchedView(){
        noneTouchedViewFrame()
        noneDisplaySliderValue()
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
    
    private func touchedViewFrame<T: RectValue>(selected: T){
        if let rectangle = selected as? Rectangle{
            let view = rectangleUIViews[rectangle]
            view?.layer.borderColor = UIColor.cyan.cgColor
            view?.layer.borderWidth = 3
            
        } else if let image = selected as? Image{
            let view = imageUIViews[image]
            view?.layer.borderColor = UIColor.cyan.cgColor
            view?.layer.borderWidth = 3
        }
        
    }
    
    private func noneDisplaySliderValue(){
        rightAttributerView.originSliderValue(red: 0, green: 0, blue: 0, alpha: 1)
        rightAttributerView.rockColorSlider()
        rightAttributerView.rockAlphaSlider()
    }
    
    private func noneTouchedViewFrame(){
        if let rectangle = selectedValue as? Rectangle{
            let view = rectangleUIViews[rectangle]
            view?.layer.borderColor = .none
            view?.layer.borderWidth = 0
            self.selectedValue = nil
            
        } else if let image = selectedValue as? Image{
            let view = imageUIViews[image]
            view?.layer.borderColor = .none
            view?.layer.borderWidth = 0
            self.selectedValue = nil
        }
    }
}


// MARK: - Use case: Click Rectangle / Image View

extension MainViewController {
    @objc func dragGesture(_ gesture: UIPanGestureRecognizer){
        let moveDistance = gesture.translation(in: self.view)
        
        switch gesture.state{
        case .began:
            let touchPoint = gesture.location(in: self.view)
            plane.findValue(withX: touchPoint.x, withY: touchPoint.y)
            
            if let rectangle = selectedValue as? Rectangle{
                panGestureExtraView = RectangleView(frame: CGRect(x: rectangle.point.x, y: rectangle.point.y, width: rectangle.size.width, height: rectangle.size.height))
                
                guard let extraView = panGestureExtraView else{
                    return
                }
                
                extraView.backgroundColor = UIColor(red: rectangle.color.redValue(), green: rectangle.color.greenValue(), blue: rectangle.color.blueValue(), alpha: 0.5)

                self.view.addSubview(extraView)
            } else if let image = selectedValue as? Image{
                panGestureExtraImageView = ImageView(frame: CGRect(x: image.point.x, y: image.point.y, width: image.size.width, height: image.size.height))
                
                guard let extraImage = panGestureExtraImageView else{
                    return
                }
                
                extraImage.image = image.image.image
                extraImage.alpha = 0.5
                
                self.view.addSubview(extraImage)
            }
        case .changed:
            if let extraView = panGestureExtraView{
                extraView.center.x += moveDistance.x
                extraView.center.y += moveDistance.y
                gesture.setTranslation(.zero, in: self.view)
            } else if let extraImage = panGestureExtraImageView{
                extraImage.center.x += moveDistance.x
                extraImage.center.y += moveDistance.y
                gesture.setTranslation(.zero, in: self.view)
            }
        case .ended:
            if let extraView = panGestureExtraView, let rectangle = selectedValue as? Rectangle{
                rectangleUIViews[rectangle]?.center.x = extraView.center.x
                rectangleUIViews[rectangle]?.center.y = extraView.center.y
                
                extraView.removeFromSuperview()
                panGestureExtraView = nil
            } else if let extraImage = panGestureExtraImageView, let image = selectedValue as? Image{
                imageUIViews[image]?.center.x = extraImage.center.x
                imageUIViews[image]?.center.y = extraImage.center.y
                
                extraImage.removeFromSuperview()
                panGestureExtraImageView = nil
            }
        default:
            return
        }
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
        guard let rectangle = selectedValue as? Rectangle, let rectView = rectangleUIViews[rectangle] else{
            return
        }
        
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        rectangle.changeColor(color: newColor)
        
        rectView.backgroundColor = UIColor(red: rectangle.color.redValue(), green: rectangle.color.greenValue(), blue: rectangle.color.blueValue(), alpha: rectangle.alpha.showValue())
    }
    
    func changeRectangleAlpha(){
        if let rectangle = selectedValue as? Rectangle{
            let rectView = rectangleUIViews[rectangle]
        
            rectangle.changeAlpha(alpha: rightAttributerView.alphaValue)
            rectView?.backgroundColor = rectView?.backgroundColor?.withAlphaComponent(rectangle.alpha.showValue())
            
        } else if let image = selectedValue as? Image{
            let imageView = imageUIViews[image]
        
            image.changeAlpha(alpha: rightAttributerView.alphaValue)
            imageView?.alpha = image.alpha.showValue()
        }
    }
}
