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
    private var button:UIButton = RectangleButton(frame: .zero)
    
    //그려진 retangleView를 Rectangle을 Key로 찾는 Dictionary로 만들어서 모델과 매칭을 시켜주었습니다.
    private var retangleViews = [Rectangle:RectangleView]()
    //선택된 rectangleView
    private var seletedRectangleView:RectangleView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plane.delegate = self
        
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
    
    //사각형 추가 버튼 정의
    private func configureRectangleButton() {
        let width = 150.0
        let height = 100.0
        let x:CGFloat = (self.view.frame.maxX / 2.0) - (width / 2)
        let y:CGFloat = (self.view.frame.maxY - height)
        
        button.layer.zPosition = 1.0                                //생성되는 사각형에 겹쳐서 클릭이 안되거나 안보이는 경우를 막기위해 zPosition을 주었다.
        button.frame = CGRect(x: x, y: y, width: width, height: height)
        button.addAction(makeRectangleAction(), for: .touchUpInside)
    }
    
    //버튼 액션정의
    private func makeRectangleAction() -> UIAction {
        let action = UIAction {_ in
            let id = IDFactory.makeRandomID()
            let size = Size(width: 150, height: 120)
            let point = Point.random()
            let rgb = RGB.random()
            let alpha = Alpha.random()
            
            let rect = Rectangle(id: id, origin: point, size: size, backGroundColor: rgb, alpha: alpha)
            
            self.plane.addRectangle(rectangle: rect)    //모델에 rectangle을 추가
        }
        return action
    }
    
    //Custom View추가
    private func addViews() {
        view.addSubview(button)
        view.addSubview(detailView)
    }
}

//MARK: -- UIGesture 처리
extension MainViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        //터치된 View의 origin x와 y값을 plane에게 넘겨줍니다.
        guard let touchedView = touch.view else { return true }
        if touchedView.frame.width == 1180 { seletedRectangleView?.layer.borderWidth = 0.0 } //빈 화면 클릭시 width을 초기화한다.
        
        //Plane에게 touch된 View의 origin좌표를 넘겨준다.
        let x:Double = touchedView.frame.origin.x
        let y:Double = touchedView.frame.origin.y
        plane.findSeletedRectangle(x: x, y: y)
        
        return true
    }
}

//MARK: -- Delegate메소드 실제 구현

//슬라이더를 움직일때 마다 현재 클릭한 모델 사각형의 alpha값을 바꾼다.
extension MainViewController:DetailViewDelgate {
    func sliderViewEndEditing(sender: UISlider) {
        let currentSliderValue = sender.value                      //silder에서 넘어온 값
        plane.change(alpha: Alpha(currentSliderValue))             //모델의 값을 바꾼다.
    }
    
    //랜덤한 RGB값을 설정하고 현재 클릭한 모델 사각형의 rgb값을 변경한다
    func colorButtonTouched(sender:UIButton) {
        let randomRGB = RGB.random()
        plane.change(color: randomRGB)
    }
}

extension MainViewController:PlaneDelegate {
    //바뀐 rgb값을 이용해서 View의 배경과 Label의 title을 바꿉니다.
    func didChangeColor(seletedRectangle: Rectangle) {
        let rgb = seletedRectangle.rgb
        let alpha = seletedRectangle.alpha
        let hexRGB = seletedRectangle.rgb.hexValue
        
        seletedRectangleView?.backgroundColor = UIColor(rgb: rgb, alpha: alpha)
        
        detailView.backgroundColorButton.setTitle("\(hexRGB)", for: .normal)
    }
    
    //찾은 Rectangle의 테두리를 바꿉니다.
    func didFindRectangle(rectrangle: Rectangle) {
        
        seletedRectangleView?.layer.borderWidth = 0.0           //기존 seletedRectangleView초기화
        
        seletedRectangleView = retangleViews[rectrangle]        //View 찾기
        
        seletedRectangleView?.layer.borderWidth = 2.0           //테두리 바꾸기
        seletedRectangleView?.layer.borderColor = UIColor.blue.cgColor
    }
    
    //Rectangle이 추가가 됬으니 View에게 알립니다.
    func didAddRectangle(rectangle: Rectangle) {
        let rgb = rectangle.rgb
        let alpha = rectangle.alpha
        let rectView = RectangleView(rect: rectangle, rgb: rgb, alpha: alpha) //View를 만듬
        
        retangleViews[rectangle] = rectView             //Dictionary에 추가
        self.view.addSubview(rectView)                  //화면에 추가
        
        //사각형 추가 버튼이나 detailView의 슬라이더가 추가된 사각형에 가려지더라도 이벤트를 발생시키기 위해서 최상단으로 View를 올렸습니다.
        self.view.bringSubviewToFront(button)
        self.view.bringSubviewToFront(detailView)
    }
    
    //Alpha가 바뀌었으니 View에게 알립니다.
    func didChangeAlpha(selectedRectangle: Rectangle) {
        seletedRectangleView?.alpha = CGFloat(selectedRectangle.alpha.value)
    }
}
