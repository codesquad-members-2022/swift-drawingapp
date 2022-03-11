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
    private let rectangleGenerationButton = UIButton()
    private let panelView = PanelView()
    
    
    //View Constants
    let screenWdith = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let buttonWidth: Double = 130
    let buttonHeight: Double = 100
    let panelWidth : Double = 200
    
    
    //[Model : View]
    private var rectangleList : [Rectangle : RectangleView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupHandlers()
        setupDelegates()
        setupLayout()
    }
    
    
    func setupSubViews() {
        view.addSubview(rectangleGenerationButton)
        view.addSubview(panelView)
    }

    func setupHandlers() {
        rectangleGenerationButton.addTarget(self, action: #selector(createRectangleModel), for:.touchUpInside)
        let tapGuestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapTriggered))
        tapGuestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGuestureRecognizer)
    }
    
    func setupDelegates(){
        panelView.delegate = self
        plane.delegate = self
    }

    func setupLayout(){
        rectangleGenerationButton.frame = CGRect(x: (screenWdith - panelWidth)/2 - (buttonWidth/2), y: screenHeight - buttonHeight, width: buttonWidth, height: buttonHeight)
        rectangleGenerationButton.layer.cornerRadius = 10
        rectangleGenerationButton.backgroundColor = .lightGray
        rectangleGenerationButton.setTitle("사각형", for: .normal)
        panelView.frame = CGRect(x: screenWdith - panelWidth, y: view.safeAreaInsets.top, width: panelWidth, height: screenHeight)
    }
    
    @objc func createRectangleModel() {
        do {
            let rectModel = try ShapeFactory(planeWidth: screenWdith - panelWidth, planeHeight: screenHeight - buttonHeight, shapeSize: Size(width: 130, height: 120)).makeRect()
            plane.append(rectModel)
        }catch{
        }
    }
    

    //MARK: Event 1.0 : 사용자가 ViewController 를 터치했을때(입력)
    @objc func tapTriggered(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        plane.searchRectangleModel(tabCoordX: point.x, tabCoordY: point.y)
    }
    
    func createRectangleView (with model: Rectangle) {
        let rectView = RectangleView(frame: CGRect(x: model.point.x.trim, y: model.point.y.trim, width: model.size.width, height: model.size.height))
        rectView.backgroundColor = UIColor(red: model.color.red.scaleRGB, green: model.color.green.scaleRGB, blue: model.color.blue.scaleRGB, alpha: model.alpha.value)

        rectangleList.updateValue(rectView, forKey: model)
        view.addSubview(rectView)
    }
    
    func manageViews(with models: [Rectangle]) {
        var parsedModels = models
        
        if models.last!.selectedStatus() == false {
            parsedModels = models.reversed()
        }
      
        for model in parsedModels {
            setHighlightView(from:model)
            updatePanel(from : model)
        }
                
    }
    
    func setHighlightView(from model: Rectangle) {
        if let rectView = rectangleList[model] {
            rectView.configure(isSelected: model.selectedStatus())
        }
    }
  
    
    func updatePanel(from model: Rectangle) {
        if model.selectedStatus() {
            panelView.updateAlphaLable(newAlphaValue: String(model.alpha.value * 10.0))
            panelView.updateRomdomizeColorButton(newColor: model.color.tohexString)
        }
        else{
            panelView.setDefaultPanelValues()
        }
    }
    

//    //MARK: 선택 되어 있는 RectangleView 의 색상을 업데이트하기.
//    func updateRectangleView(at view : RectangleView? , with model: Rectangle?) {
//        if let rectView = view, let rectModel = model {
//            rectView.updateColor(with: rectModel)
//            rectView.updateAlpha(newAlpha: rectModel.alpha.value)
//        }
//    }
//
//

//

//
//    func updateStepper(to value : Double) {
//        self.alphaStepper.updateValue(value)
//        self.stepperLabel.updateText(String(value))
//    }
//
//}
//
////MARK: Event 1.0 사용자가 “사각형” 버튼을 누를시 “RectangleView” 를 생성한다 (1/2)
   
//extension ViewController : GenerateRectangleButtonDelegate {
//    //사각형 생성 버튼이 눌리면 함수 정의
//    func didTapGenerateButton() {
//        do {
//            let rectModel = try ShapeFactory(planeWidth: screenWdith - panelWidth, planeHeight: screenHeight - buttonHeight, shapeSize: Size(width: 130, height: 120)).makeRect()
//            os_log(.debug, "\(rectModel)")
//            plane.append(rectModel)
//        }catch{
//        }
//    }
//}
//

//
////MARK: Event 3.0 : 사용자가 RectangleView 를 터치했을때 그 사각형에 대한 정보를 패널에 정보를 표시한다.
//extension ViewController : RectangleViewDelegate {
//    func didTouchRectView(rectView: RectangleView) {
//        updatePanel(with: targetModel)
//    }
//}
//
////MARK: Event 4.0 : 사용자가 ColorRondomizeButton 를 터치했을때 그 사각형에 대한 정보를 패널에 정보를 표시한다. (1/2)
//extension ViewController : ColorRondomizeButtonDelegate {
//    func generateRandomColor(sender: ColorRondomizeButton) {
//        let hexColor = sender.currentTitle
//        if targetModel?.color.tohexString == hexColor {
//            targetModel?.randomizeColor()
//        }
//    }
//}
//
//
////MARK: Event 5.0 : 사용자가 AlphaStepper 를 터치했을때 그 사각형에 대한 정보를 패널에 정보를 표시한다. (1/2)
//extension ViewController : AlphaStepperDelegate {
//    func changeAlpha(sender: AlphaStepper) {
//        //사각형 모델 알파 값 변경.
//        if let alpha = Alpha(rawValue: Int(sender.value)) {
//            targetModel?.updateAlpha(alpha)
//        }
//    }
//}
//
////MARK: Event 4.0 : 사용자가 ColorRondomizeButton 를 터치했을때 그 사각형에 대한 정보를 패널에 정보를 표시한다. (2/2)
////MARK: Event 5.0 : 사용자가 AlphaStepper 를 터치했을때 그 사각형에 대한 정보를 패널에 정보를 표시한다. (2/2)
//extension ViewController: RectangleDelegate {
//    func didChangeProperty(sender: Rectangle) {
//        updatePanel(with: targetModel)
//        updateRectangleView(at: targetView, with: targetModel)
//    }
//}

    
}

//MARK: Event 1.0 사용자가 “사각형” 버튼을 누를시 “RectangleView” 를 생성한다 (2/2)
extension ViewController : PlaneDelegate {
   
    func didSearchForRectangleModel(detectedModels: [Rectangle]) {
    
        if detectedModels.isEmpty {
            panelView.setDefaultPanelValues()
        }else {
            manageViews(with: detectedModels)
        }
    }

    func didAppendRectangleModel(rectModel: Rectangle?) {
        if let appendedRect = rectModel {
            createRectangleView(with : appendedRect)
        }
    }
}

extension ViewController : PanelViewDelegate {
    func didTabRondomizeColor() {
        //
    }
    
    func didTabChangeAlpha() {
        //
    }

}

