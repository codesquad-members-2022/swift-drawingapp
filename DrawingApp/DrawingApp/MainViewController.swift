//
//  ViewController.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/02/28.
//

import UIKit
import OSLog

final class MainViewController: UIViewController{
    
    //model
    private var plane = Plane()
    //view
    private var detailView = DetailView(frame: .zero)       //생성시 오해를 막고 기존 생성자와 관련있게 하기 위해 frame에 .zero를 대입했습니다.
    private var rectangleButton:UIButton = RectangleButton(frame: .zero)
    private var imageButton:UIButton = ImageButton(frame: .zero)
    //Factory
    private let rectangleFactory = RectangleFactory()
    
    //그려진 PlaneRetangleView를 모델(Rectangle)을 Key로 찾는 Dictionary로 만들어서 모델과 매칭을 시켜주었습니다.
    private var retangleViews = [PlaneRectangle:PlaneRectangleView]()
    //선택된 PlaneRectangleView
    private var seletedRectangleView:PlaneRectangleView?
    
    private let imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNotificationCenter()
        
        configureImageButton()
        configureRectangleButton()
        configureDeatailView()
        configureTapGesture()
        addViews()
    }
    
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
    
    private func configureImageButton() {
        let width = 150.0
        let height = 100.0
        let x:CGFloat = (self.view.frame.maxX / 2.0) - (width / 2) - width
        let y:CGFloat = (self.view.frame.maxY - height)
        
        imageButton.layer.zPosition = 1.0
        imageButton.frame = CGRect(x: x, y: y, width: width, height: height)
        imageButton.addAction(addImageRectangleAction(), for: .touchUpInside)
    }
    
    private func addImageRectangleAction() -> UIAction {
        let action = UIAction {[weak self] _ in
            guard let rect = self?.rectangleFactory.makePlaneRectangle() else { return }
            self?.plane.addRectangle(rectangle: rect)    //모델에 rectangle을 추가
        }
        return action
    }
    
    
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
            guard let rect = self?.rectangleFactory.makePlaneRectangle() else { return }
            self?.plane.addRectangle(rectangle: rect)    //모델에 rectangle을 추가
        }
        return action
    }
    
    //Custom View추가
    private func addViews() {
        view.addSubview(rectangleButton)
        view.addSubview(detailView)
        view.addSubview(imageButton)
    }
}

//MARK: -- UIGesture 처리
extension MainViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        //터치된 View의 origin x와 y값을 plane에게 넘겨줍니다.
        guard let touchedView = touch.view else { return true }
        
        //Plane에게 touch된 View의 origin좌표를 넘겨준다.
        let x:Double = touchedView.frame.origin.x
        let y:Double = touchedView.frame.origin.y
        let size:Size = Size(width: touchedView.frame.size.width, height: touchedView.frame.size.height)
        plane.findSeletedRectangle(x: x, y: y, size: size)
        
        return true
    }
    
    //MARK: -- NotificationCenter
    private func configureNotificationCenter() {
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
    @objc func changeColor(_ notification:Notification) {
        guard let newRGB = notification.userInfo?[Plane.UserInfoKey.changedColor] as? RGB else { return }
        let alpha:Alpha = Alpha(Float(seletedRectangleView?.alpha ?? 0.0))
        
        seletedRectangleView?.backgroundColor = UIColor(rgb: newRGB, alpha: alpha)
        
        detailView.backgroundColorButton.setTitle("\(newRGB.hexValue)", for: .normal)
    }
    
    
    //ChangeAlpha
    @objc func changeAlpha(_ notification:Notification) {
        guard let newAlpha = notification.userInfo?[Plane.UserInfoKey.changedAlpha] as? Alpha else { return }
        seletedRectangleView?.alpha = CGFloat(newAlpha.value)
    }
    
    
    //addRectagnleView
    @objc func addRectangleView(_ notification:Notification) {
        guard let newRectangle = notification.userInfo?[Plane.UserInfoKey.addedRectangle] as? PlaneRectangle else { return }
        
        let rectangleView = PlaneRectangleView(rect: newRectangle, rgb: newRectangle.rgb, alpha: newRectangle.alpha)
        view.addSubview(rectangleView)
        
        self.retangleViews[newRectangle] = rectangleView
        
        self.view.bringSubviewToFront(rectangleButton)
        self.view.bringSubviewToFront(detailView)
    }
    
    //findSelected Rectangle & Set View
    @objc func findSelectedRectangle(_ notification:Notification) {
        seletedRectangleView?.layer.borderWidth = .zero
        
        guard let seletedRectangle = notification.userInfo?[Plane.UserInfoKey.foundRectangle] as? PlaneRectangle else { return }
        
        let rectangleView = self.retangleViews[seletedRectangle]
        self.seletedRectangleView = rectangleView
        
        seletedRectangleView?.layer.borderWidth = 2.0
        seletedRectangleView?.layer.borderColor = UIColor.blue.cgColor
        
        self.detailView.alphaLabel.text = "\(seletedRectangle.alpha.value)"
        self.detailView.alphaSlider.value = seletedRectangle.alpha.value
        
        self.detailView.backgroundColorButton.setTitle("\(seletedRectangle.rgb.hexValue)", for: .normal)
    }
}

//MARK: -- DetailViewDelegate
//슬라이더를 움직일때 마다 현재 클릭한 모델 사각형의 alpha값을 바꾼다.
extension MainViewController:DetailViewDelgate {
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


