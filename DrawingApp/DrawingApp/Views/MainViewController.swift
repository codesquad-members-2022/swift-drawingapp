//
//  MainViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit

typealias MainAction = MainViewController.MainAction

final class MainViewController: UIViewController {
    
    @IBOutlet weak var buttonSetRandomColor: UIButton!
    @IBOutlet weak var sliderSetAlpha: UISlider!
    
    private var defaultButtonColor: UIColor!
    
    private let plane = Plane()
    private var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultButtonColor = buttonSetRandomColor.backgroundColor
        
        NotificationCenter.default.addObserver(
            forName: Plane.RectangleViewTouched,
            object: nil,
            queue: OperationQueue.main
        ) { [weak self] noti in
            guard let self = self else { return }
            
            self.currentIndex = noti.userInfo?[Plane.PostKey.index] as? Int
            
            let button = self.buttonSetRandomColor
            let slider = self.sliderSetAlpha
            
            guard let property = noti.object as? RectangleProperty else {
                button?.backgroundColor = self.defaultButtonColor
                slider?.setValue(0, animated: true)
                return
            }
            
            button?.backgroundColor = property.rgbValue.getColor(alpha: property.alpha)
            slider?.setValue(Float(property.alpha), animated: true)
        }
    }
    
    @IBAction func buttonForAddTouchUpInside(_ sender: UIButton) {
        plane.addRectangle()
    }
    
    @IBAction func buttonAdmitColorTouchUpInside(_ sender: UIButton) {
        guard
            let index = currentIndex,
            let color = plane.resetRandomColor(at: index)
        else {
            return
        }
        
        buttonSetRandomColor.backgroundColor = color.getColor(alpha: Double(sliderSetAlpha.value))
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        guard let index = currentIndex else { return }
        
        sender.value = round(sender.value)
        plane.setAlpha(value: sender.value, at: index)
        
        let color = buttonSetRandomColor.backgroundColor
        buttonSetRandomColor.backgroundColor =
            color?.withAlphaComponent(Double(sender.value)/RectRGBColor.maxAlpha)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainScreenViewController {
            plane.screenDelegate = vc
            vc.delegate = plane
        }
    }
    
    /// root view의 액션 타입
    ///
    /// ViewController -> Plane -> MainScreenViewController
    enum MainAction {
        /// 무작위 색상 버튼을 선택
        case ColorButtonPushed
        /// 투명도 슬라이더 움직임
        case SliderMoved
        /// 사각형 추가 버튼을 선택
        case AddButtonPushed
    }
}
