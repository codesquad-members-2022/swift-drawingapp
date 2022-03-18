//
//  ViewController.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/02/28.
//

import UIKit
import OSLog
import PhotosUI

typealias RectangleView = UIView
typealias imageURLData = Data

final class MainViewController: UIViewController{
    
    //model
    private var plane = Plane()
    private var image = Image()
    //view
    private var detailView = DetailView(frame: .zero)       //생성시 오해를 막고 기존 생성자와 관련있게 하기 위해 frame에 .zero를 대입했습니다.
    private var rectangleButton:UIButton = RectangleButton(frame: .zero)
    private var imageButton:UIButton = ImageButton(frame: .zero)
    
    private var rectangleViews = [PlaneRectangle:RectangleView]()
    private var imageRectangleViews = [imageURLData:RectangleView]()
    
    //선택된 PlaneRectangleView
    private var seletedRectangleView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePlaneNotificationCenter()
        configureImageNotificationCenter()
        
        configureTapGesture()
        
        configureImageButton()
        configureRectangleButton()
        configureDeatailView()
        addViews()
    }
    

    //MARK: -- ImageButton
    private func configureImageButton() {
        let width = 150.0
        let height = 100.0
        let x:CGFloat = (self.view.frame.maxX / 2.0) - (width / 2) - width
        let y:CGFloat = (self.view.frame.maxY - height)
        
        imageButton.layer.zPosition = 1.0
        imageButton.frame = CGRect(x: x, y: y, width: width, height: height)
        imageButton.addAction(addImageAction(), for: .touchUpInside)
    }
    
    //버튼 액션 - 이미지 추가
    private func addImageAction() -> UIAction {
        let action = UIAction {[weak self] _ in
            guard let picker = self?.configurePHPicker() else { return }
            self?.present(picker, animated: true, completion: nil)
        }
        return action
    }
    
    
    
    //MARK: -- RectangleButton
    //사각형 추가 버튼 Frame정의 및 Action추가.
    private func configureRectangleButton() {
        let width = 150.0
        let height = 100.0
        let x:CGFloat = (self.view.frame.maxX / 2.0) - (width / 2)
        let y:CGFloat = (self.view.frame.maxY - height)
        
        rectangleButton.layer.zPosition = 1.0                                //생성되는 사각형에 겹쳐서 안보이는 경우를 막기위해 zPosition을 주었다.
        
        rectangleButton.frame = CGRect(x: x, y: y, width: width, height: height)
        rectangleButton.addAction(addRectangleAction(), for: .touchUpInside)
    }
    
    //버튼 액션 - 사각형 추가
    private func addRectangleAction() -> UIAction {
        let action = UIAction {[weak self] _ in
            self?.plane.addRectangle()
        }
        return action
    }
    
    //MARK: -- Else
    //TapGesture
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //DetailView
    private func configureDeatailView() {
        detailView.delegate = self
        detailView.layer.zPosition = 1.0                        //생성되는 사각형에 겹쳐서 클릭이 안되거나 안보이는 경우를 막기위해 zPosition을 주었다.
        
        let inset:CGFloat = 200
        detailView.frame = CGRect(x:self.view.frame.maxX - inset,
                                  y: 0,
                                  width: inset,
                                  height: self.view.frame.height
        )
    }
    
    //Custom View추가
    private func addViews() {
        view.addSubview(rectangleButton)
        view.addSubview(detailView)
        view.addSubview(imageButton)
    }
    
    //MARK: -- PlaneNotificationCenter
    private func configurePlaneNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(addRectangleView),
            name: Plane.NotificationName.didAddRectangle,
            object: plane )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(findSelectedRectangle),
            name: Plane.NotificationName.didFindRectangle,
            object: plane )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeAlpha),
            name: Plane.NotificationName.didchangeRectangleAlpha,
            object: plane )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(changeColor),
            name: Plane.NotificationName.didChangeRectangleColor,
            object: plane )
    }
    
    //ChangeColor
    @objc private func changeColor(_ notification:Notification) {
        guard let newRGB = notification.userInfo?[Plane.UserInfoKey.changedColor] as? RGB else { return }
        let alpha:Alpha = Alpha(Float(seletedRectangleView?.alpha ?? 0.0))
        
        seletedRectangleView?.backgroundColor = UIColor(rgb: newRGB, alpha: alpha)
        
        detailView.backgroundColorButton.setTitle("\(newRGB.hexValue)", for: .normal)
    }
    
    
    //ChangeAlpha
    @objc private func changeAlpha(_ notification:Notification) {
        guard let newAlpha = notification.userInfo?[Plane.UserInfoKey.changedAlpha] as? Alpha else { return }
        seletedRectangleView?.alpha = CGFloat(newAlpha.value)
    }
    
    
    //addRectagnleView
    @objc private func addRectangleView(_ notification:Notification) {
        guard let newRectangle = notification.userInfo?[Plane.UserInfoKey.addedRectangle] as? PlaneRectangle else { return }
        let rectangleView = RectangleViewFactory.makePlaneRectangleView(sourceRectangle: newRectangle)
        
        self.rectangleViews[newRectangle] = rectangleView
        
        view.addSubview(rectangleView)
        self.view.bringSubviewToFront(rectangleButton)
        self.view.bringSubviewToFront(detailView)
    }
    
    //findSelected Rectangle & Set View
    @objc private func findSelectedRectangle(_ notification:Notification) {
        seletedRectangleView?.layer.borderWidth = .zero
        
        guard let seletedRectangle = notification.userInfo?[Plane.UserInfoKey.foundRectangle] as? PlaneRectangle else { return }
        
        let rectangleView = self.rectangleViews[seletedRectangle]
        self.seletedRectangleView = rectangleView
        
        seletedRectangleView?.layer.borderWidth = 2.0
        seletedRectangleView?.layer.borderColor = UIColor.blue.cgColor
        
        self.detailView.alphaLabel.text = "\(seletedRectangle.alpha.value)"
        self.detailView.alphaSlider.value = seletedRectangle.alpha.value
        
        self.detailView.backgroundColorButton.setTitle("\(seletedRectangle.rgb.hexValue)", for: .normal)
    }
    //MARK: -- ImageNotificationCenter
        private func configureImageNotificationCenter() {
            NotificationCenter.default.addObserver(
                self,
                selector:#selector(addImageRectangleView),
                name: Image.NotificationName.didAddRectangle,
                object: image
            )
        }
    
    @objc private func addImageRectangleView(_ notification:Notification) {
        guard let newImageRectangle = notification.userInfo?[Image.UserInfoKey.addedImageRectangle] as? ImageRectangle else { return }
        
        DispatchQueue.main.async { [weak self]  in
            guard let self = self else { return  }
            let rectangleView = RectangleViewFactory.makeImageRectangleView(sourceRectangle: newImageRectangle)
            self.imageRectangleViews[newImageRectangle.imageData] = rectangleView
            print(rectangleView)
            self.view.addSubview(rectangleView)

            self.view.bringSubviewToFront(self.rectangleButton)
            self.view.bringSubviewToFront(self.detailView)
        }
    }
}




//MARK: -- UIGesture 처리
extension MainViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        //Plane에게 touch된 View의 origin좌표를 넘겨준다.
        let x = Double(touch.location(in: self.view).x)
        let y = Double(touch.location(in: self.view).y)
        let point = Point(x: x, y: y)
        plane.findSeletedRectangle(point: point)
        
        return true
    }
}

//MARK: -- DetailViewDelegate
//슬라이더를 움직일때 마다 현재 클릭한 모델 사각형의 alpha값을 바꾼다.
extension MainViewController:DetailViewDelegate {
    func sliderViewEndEditing(sender: UISlider) {
        let currentSliderValue = sender.value
        plane.change(alpha: Alpha(currentSliderValue))
    }
    
    //랜덤한 RGB값을 설정하고 현재 클릭한 모델 사각형의 rgb값을 변경한다
    func colorButtonTouched(sender:UIButton) {
        let randomRGB = RGB.random()
        plane.change(color: randomRGB)
    }
}

//MARK: -- PHPikcer
extension MainViewController:PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let itemProvider = results.first?.itemProvider else { return }
        //Can Load?
        guard itemProvider.canLoadObject(ofClass: UIImage.self) == true else { return }
        //Then Load
        itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { [weak self] url, Error in
            guard let url = url else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            self?.image.addRectangle(imageData: data)
        }
    }
    
    private func configurePHPicker() -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        return picker
    }
}
