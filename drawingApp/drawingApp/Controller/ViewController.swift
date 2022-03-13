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
    private var plane : Plane!
    
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
    private var rectangleList : [Model : RectangleView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.plane = Plane(planeSize: Size(width: screenWdith - panelWidth, height: screenHeight - buttonHeight), safeAreaInsets: Point(x: 0, y:20))
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
   
    //MARK: 사용자가 사각형 버튼을 누르면 plane 구역안에 뷰를 생성 시켜줄 팩토리 를 이용하여 모델생성 및 plane 에 추가.
    @objc func createRectangleModel() {
        plane.addModel()
    }
    

    //MARK: 사용자가 ViewController 를 터치했을때 좌표를 기준으로 사각형을 찾음.
    @objc func tapTriggered(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        plane.searchForModel(tabCoordX: point.x, tabCoordY: point.y)
    }
    
    func createRectangleView (with model: Model) {
  
        let rectView = RectangleView(frame: CGRect(x: model.point.x.trim, y: model.point.y.trim, width: model.size.width, height: model.size.height))
        rectView.backgroundColor = UIColor(red: model.color.red.scaleRGB, green: model.color.green.scaleRGB, blue: model.color.blue.scaleRGB, alpha: model.alpha.value)

        rectangleList.updateValue(rectView, forKey: model)
        view.addSubview(rectView)
    }
    
    //MARK: 사각형 뷰 선택에 따른 테두리 및 패널 뷰처리 함수.
    func manageSelectingViews(on models: [Model]) {
        var parsedModels = models
        
        if models.last!.selectedStatus() == false {
            parsedModels = models.reversed()
        }
      
        for model in parsedModels {
            updateHighlight(from:model)
            updatePanel(from : model)
        }
                
    }

    func updateHighlight(from model: Model) {
        if let rectView = rectangleList[model] {
            rectView.configure(isSelected: model.selectedStatus())
        }
    }
  
    
    func updatePanel(from model: Model) {
        if model.selectedStatus() {
            panelView.updateAlpha(newAlphaValue: model.alpha.value)
            panelView.updateRomdomizeColorButton(newColor: model.color.tohexString)
        }
        else{
            panelView.setDefaultPanelValues()
        }
    }
    
    //MARK: 색상, 알파 수정에 대한 뷰처리 함수.
    func manageAmendingViews(by model: Model, operation : (Model) -> ()){
        return operation(model)
    }
    
    func colorRandomization(on model: Model) {
        if let rectView = rectangleList[model] {
            rectView.updateColor(with: model)
            updatePanel(from: model)
        }
    }


    func alphaModification(on model : Model){
        if let rectView = rectangleList[model] {
         rectView.updateAlpha(newAlpha: model.alpha.value)
         updatePanel(from: model)
        }
        
    }

}

// 출력 관련 델리게이션 함수
extension ViewController : PlaneDelegate {
    
    func didSearchForModel(detectedModel: Model?) {
        if let model = detectedModel  {
            panelView.setDefaultPanelValues()
        }else {
            manageSelectingViews(on: detectedModel)
        }
    }

    func didAppendModel(model: Model?) {
        if let appendedModel = model {
            createRectangleView(with : appendedModel)
        }
    }

    func didRandomizeColor(model: Model) {
        manageAmendingViews(by: model, operation: colorRandomization)
    }
    
    func didChangeAlpha(model: Model) {
        manageAmendingViews(by: model, operation: alphaModification)
    }
    
    
}

//입력 관련 델리게이션 함수 
extension ViewController : PanelViewDelegate {
//    func didTabRondomizeColor() {
//        if let selectedModel = plane.getSelectedModel(){
//            plane.randomizeColor(on: selectedModel)
//        }
//    }
//    
//    func didTabChangeAlpha(from: UIStepper) {
//        if let selectedModel = plane.getSelectedModel(){
//            plane.changeAlpha(on: selectedModel, with: Alpha(rawValue: Int(from.value)))
//        }
//    }
}

