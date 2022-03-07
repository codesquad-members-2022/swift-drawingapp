//
//  ViewController.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/02/28.
//

import UIKit
import OSLog
class ViewController: UIViewController {
    
    //Model
    private var plane = Plane()
    
    //Views
    private let rectangleGenerationButton = RectangleGenerationButton()
    private let panel = PanelView()
    private let colorRondomizeButton = ColorRondomizeButton()
    private let alphaStepper = AlphaStepper()
    private let stepperLabel = StepperLabel()
    
    
    //View Constants
    let screenWdith = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let buttonWidth: Double = 130
    let buttonHeight: Double = 100
    let panelWidth : Double = 200
    
    
    //Targets
    private var targetModel : Rectangle?
    private var targetView : RectangleView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupGestureRecognizer()
        setupDelegates()
    }
    
    override func viewWillLayoutSubviews() {
        setupLayout()
    }
    
    
    func setupSubViews() {
        view.addSubview(rectangleGenerationButton)
        view.addSubview(panel)
        view.addSubview(colorRondomizeButton)
        view.addSubview(alphaStepper)
        view.addSubview(stepperLabel)
    }

    func setupGestureRecognizer() {
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTriggered))
        tapGuestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGuestureRecognizer)
    }
    
    func setupDelegates(){
        rectangleGenerationButton.delegate = self
        plane.delegate = self
        colorRondomizeButton.delegate = self
        alphaStepper.delegate = self
    }
    
    func setupLayout(){
        rectangleGenerationButton.frame = CGRect(x: (screenWdith - panelWidth)/2 - (buttonWidth/2), y: screenHeight - buttonHeight, width: buttonWidth, height: buttonHeight)
        panel.frame = CGRect(x: screenWdith - panelWidth, y: view.safeAreaInsets.top, width: panelWidth, height: screenHeight)
        colorRondomizeButton.frame = CGRect(x: (screenWdith - panelWidth) + 20, y: view.safeAreaInsets.top + 70.0, width: 160, height: 50)
        alphaStepper.frame = CGRect(x: (screenWdith - panelWidth) + 100, y: view.safeAreaInsets.top + 190.0, width: 160, height: 50)
        stepperLabel.frame = CGRect(x: (screenWdith - panelWidth) + 55, y: view.safeAreaInsets.top + 185.0, width: 160, height: 50)

    }
    
    //MARK: 탭 제스쳐 메소드
    @objc func tapTriggered(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        let presentedRectViews = view.subviews.compactMap{$0 as? RectangleView}
        
        if let detectedMoodel = plane.detectRect(x: point.x, y: point.y) {
            targetModel = detectedMoodel
            targetModel?.delegate = self
            targetView = view.hitTest(sender.location(in: self.view), with: nil) as? RectangleView
            targetView?.delegate = self
            selectHighlight(at: targetView, on: presentedRectViews)
        }
        else {
            targetView = nil
            targetModel = nil
            dismissSelectHighlight(on: presentedRectViews)
        }
    }
    
    // MARK: 선택한 사각형뷰 Highlight 메소드.
    func selectHighlight(at detectedView: RectangleView?, on presentedRectViews : [RectangleView]) {
        if let rectView = detectedView {
            os_log(.debug,"사각형 뷰정보 : \(rectView)")
            for view in presentedRectViews {
                if rectView == view {
                    invertSelectConfiguration(rectView)
                }else{
                    view.configure(didSelect: false)
                    view.selected = false
                }
            }
        }
    }
    
    func invertSelectConfiguration (_ rectView: RectangleView){
        if rectView.selected {
            rectView.configure(didSelect: false)
            resetPanel()
        }else{
            rectView.configure(didSelect: true)
        }
        rectView.selected = !rectView.selected
    }
    
    func dismissSelectHighlight(on presentedRectView : [RectangleView]) {
        for view in presentedRectView{
            view.configure(didSelect: false)
            view.selected = false
        }
        resetPanel()
    }

    func resetPanel() {
        colorRondomizeButton.setTitle("", for: .normal)
        updateStepper(to: 0)
    }


    
    //MARK: 선택 되어 있는 RectangleView 의 색상을 업데이트하기.
    func updateRectangleView(at view : RectangleView? , with model: Rectangle?) {
        if let rectView = view, let rectModel = model {
            rectView.updateColor(with: rectModel)
            rectView.updateAlpha(newAlpha: rectModel.alpha.value)
        }
    }
    
    func updateRectangleViewAlpha(with alpha: Double){
        let presentedRectViews = view.subviews.compactMap{$0 as? RectangleView}
        for rectView in presentedRectViews {
            if rectView.selected{
                rectView.updateAlpha(newAlpha: alpha)
            }
        }
    }
    
    func updatePanel(with model : Rectangle?) {
        if let rectModel = model {
            updateColorRondomizeButton(to : rectModel.color.tohexString)
            updateStepper(to: (rectModel.alpha.value * 10))
        }
    }
    
    func updateColorRondomizeButton(to str : String?) {
        if let newString = str {
            colorRondomizeButton.setTitle(newString, for: .normal)
        }
    }
    
    func updateStepper(to value : Double) {
        self.alphaStepper.updateValue(value)
        self.stepperLabel.updateText(String(value))
    }
    
}

//MARK: Delegates
extension ViewController : GenerateRectangleButtonDelegate {
    //사각형 생성 버튼이 눌리면 함수 정의
    func didTapGenerateButton() {
        do {
            let rect = try ShapeFactory(planeWidth: screenWdith - panelWidth, planeHeight: screenHeight - buttonHeight, shapeSize: Size(width: 130, height: 120)).makeRect()
            os_log(.debug, "\(rect)")
            plane.append(rect)
        }catch{
        }
    }
}

extension ViewController : PlaneDelegate {
    func didAppendRect(rect: Rectangle?) {
        if let appendedRect = rect {
            let rectView = RectangleView(frame: CGRect(x: appendedRect.point.x.trim, y: appendedRect.point.y.trim, width: appendedRect.size.width, height: appendedRect.size.height))
            rectView.backgroundColor = UIColor(red: appendedRect.color.red.scaleRGB, green: appendedRect.color.green.scaleRGB, blue: appendedRect.color.blue.scaleRGB, alpha: appendedRect.alpha.value)
            view.addSubview(rectView)
        }
    }
}

extension ViewController : RectangleViewDelegate {
    func didTouchRectView(rectView: RectangleView) {
        updatePanel(with: targetModel)
    }
}


extension ViewController : ColorRondomizeButtonDelegate {
    func generateRandomColor(sender: ColorRondomizeButton) {
        let hexColor = sender.currentTitle
        if targetModel?.color.tohexString == hexColor {
            targetModel?.randomizeColor()
            updatePanel(with: targetModel)
            updateRectangleView(at: targetView, with: targetModel)
        }
    }
}

extension ViewController : AlphaStepperDelegate {
    func changeAlpha(sender: AlphaStepper) {
        //사각형 모델 알파 값 변경.
        if let alpha = Alpha(rawValue: Int(sender.value)) {
            targetModel?.updateAlpha(alpha)
            
        }
    }
}

extension ViewController: RectangleDelegate {
    func didChangeAlpha(sender: Rectangle) {
        updatePanel(with: targetModel)
        updateRectangleView(at: targetView, with: targetModel)
    }
}
