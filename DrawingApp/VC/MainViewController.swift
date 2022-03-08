//
//  ViewController.swift
//  DrawingApp
//
//  Created by juntaek.oh on 2022/02/28.
//

import UIKit
import os

class MainViewController: UIViewController{
    private var rectanglePlane = RectanglePlane()
    private var imageRectanglePlane = ImagePlane()
    private let rectFactory = RectangleFactory()
    private let rightAttributerView = RightAttributerView()
    private let imagePicker = UIImagePickerController()
    
    private var rectangleUIViews = [Rectangle : RectangleView]()
    private var selectedRectangle: Rectangle?
    
    private var imageUIViews = [Image : ImageView]()
    private var selectedImage: Image?
    
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
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        addRectangleMakerButtonObserver()
        addGestureRecognizerObserver()
        addNoneClickedRectangleObserver()
    }
}


// MARK: - Use case: Make RectangleView

extension MainViewController{
    @IBAction func makeRandomRectangle(_ sender: Any) {
        let rectangleValue = rectFactory.makeRandomRectangle(viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
        rectanglePlane.addRectangle(rectangle: rectangleValue)
    }
    
    @objc func addRectangleView(_ notification: Notification){
        guard let rectangleValue = notification.userInfo?[RectanglePlane.userInfoKey] as? Rectangle else { return }
        
        let rectangleView = RectangleView(frame: CGRect(x: rectangleValue.point.x, y: rectangleValue.point.y, width: rectangleValue.size.width, height: rectangleValue.size.height))
        rectangleView.backgroundColor = UIColor(red: rectangleValue.showColor().redValue(), green: rectangleValue.showColor().blueValue(), blue: rectangleValue.showColor().greenValue(), alpha: rectangleValue.showAlpha().showValue())
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
            let imageValue = rectFactory.makeRandomImageRectangle(image: MyImage(image: pickedImage), viewWidth: self.rightAttributerView.frame.minX, viewHeight: self.rectangleButton.frame.minY)
            imageRectanglePlane.addRectangle(imageRectangle: imageValue)
        }

        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func addImageRectangleView(_ notification: Notification){
        guard let imageValue = notification.userInfo?[ImagePlane.userInfoKey] as? Image else { return }
        
        let imageView = ImageView(frame: CGRect(x: imageValue.point.x, y: imageValue.point.y, width: imageValue.size.width, height: imageValue.size.height))
        imageView.backgroundColor = imageView.backgroundColor?.withAlphaComponent(imageValue.showAlpha().showValue())
        imageView.image = imageValue.image.image
        
        self.view.addSubview(imageView)
        //rectangleUIViews[rectangleValue] = rectangleView
        
        os_log("%@", "\(imageValue.description)")
    }
}


// MARK: - Use case: Add observers

extension MainViewController{
    private func addRectangleMakerButtonObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(addRectangleView(_:)), name: RectanglePlane.makeRectangle, object: rectanglePlane)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addImageRectangleView(_:)), name: ImagePlane.makeImageRectangle, object: imageRectanglePlane)
    }
    
    private func addGestureRecognizerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showTouchedView(_:)), name: RectanglePlane.selectRectangle, object: rectanglePlane)
    }
    
    private func addNoneClickedRectangleObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(showNonTouchedView), name: RectanglePlane.noneSelectRectangle, object: rectanglePlane)
    }
}


// MARK: - Use case: Click Rectangle

extension MainViewController {
    @objc func tapGesture(_ gesture: UITapGestureRecognizer){
        let touchPoint = gesture.location(in: self.view)
        rectanglePlane.findRectangle(withX: touchPoint.x, withY: touchPoint.y)
        
        return
    }
    
    @objc func showTouchedView(_ notification: Notification){
        guard let rectangle = notification.userInfo?[RectanglePlane.userInfoKey] as? Rectangle, let rectangleView = rectangleUIViews[rectangle] else{
            return
        }
        
        if let selected = selectedRectangle, let view = rectangleUIViews[selected]{
            noneTouchedViewFrame(view: view)
        }
        
        selectedRectangle = rectangle
        
        displaySliderValue(rectangle: rectangle)
        touchedViewFrame(view: rectangleView)
    }
    
    private func displaySliderValue(rectangle: Rectangle){
        rightAttributerView.originSliderValue(red: Float(rectangle.showColor().red), green: Float(rectangle.showColor().green), blue: Float(rectangle.showColor().blue), alpha: Float(rectangle.showAlpha().showValue()))
    }
    
    private func touchedViewFrame(view: RectangleView){
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.borderWidth = 3
    }
    
    @objc func showNonTouchedView(){
        guard let rectangle = selectedRectangle, let rectangleView = rectangleUIViews[rectangle] else{
            return
        }
        
        noneTouchedViewFrame(view: rectangleView)
        noneDisplaySliderValue(rectangle: rectangle)
        
        self.selectedRectangle = nil
    }
    
    private func noneDisplaySliderValue(rectangle: Rectangle){
        rightAttributerView.originSliderValue(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    private func noneTouchedViewFrame(view: RectangleView){
        view.layer.borderColor = .none
        view.layer.borderWidth = 0
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
        guard let rectangle = selectedRectangle, let rectView = rectangleUIViews[rectangle] else{
            return
        }
        
        let newColor = RGBColor(red: rightAttributerView.redValue, green: rightAttributerView.greenValue, blue: rightAttributerView.blueValue)
        rectangle.changeColor(color: newColor)
        
        rectView.backgroundColor = UIColor(red: rectangle.showColor().redValue(), green: rectangle.showColor().greenValue(), blue: rectangle.showColor().blueValue(), alpha: rectangle.showAlpha().showValue())
    }
    
    func changeRectangleAlpha(){
        guard let rectangle = selectedRectangle, let rectView = rectangleUIViews[rectangle] else{
            return
        }
        
        let newAlpha = rightAttributerView.alphaValue
        rectangle.changeAlpha(alpha: newAlpha)
        
        rectView.backgroundColor = rectView.backgroundColor?.withAlphaComponent(rectangle.showAlpha().showValue())
    }
}
