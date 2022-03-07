//
//  ViewController.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/02/28.
//

import UIKit

/// Plane 객체의 값을 ViewController의 요소들에 적용하기 위한 Protocol입니다.
protocol PlaneAdmitDelegate {
    /// Plane객체의 값이 있을 경우 ViewController에 신호를 보냅니다.
    func admitPlane(property: RectangleProperty)
    /// ViewController에 저장된 기본 값(혹은 0 등)으로 뷰를 지정하도록 신호를 보냅니다.
    func admitDefault()
}

final class ViewController: UIViewController, PlaneAdmitDelegate {
    
    @IBOutlet weak var buttonSetRandomColor: UIButton!
    @IBOutlet weak var sliderSetAlpha: UISlider!
    var defaultButtonColor: UIColor!
    
    let plane = Plane()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plane.planeDelegate = self
        
        defaultButtonColor = buttonSetRandomColor.backgroundColor
    }
    
    @IBAction func buttonForAddTouchUpInside(_ sender: UIButton) {
        plane.addRectangle()
    }
    
    @IBAction func buttonAdmitColorTouchUpInside(_ sender: UIButton) {
        guard let color = plane.setRandomColor() else {
            return
        }
        
        buttonSetRandomColor.backgroundColor = UIColor(
            red: color.r/255,
            green: color.g/255,
            blue: color.b/255,
            alpha: CGFloat(sliderSetAlpha.value)
        )
    }
    
    @IBAction func sliderAdmitAlphaValueChanged(_ sender: UISlider) {
        sender.value = round(sender.value)
        plane.setAlpha(value: sender.value)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MainScreenViewController {
            plane.screenDelegate = vc
            vc.delegate = plane
        }
    }
    
    // MARK: - PlaneAdmitDelegate implementation
    func admitPlane(property: RectangleProperty) {
        let color = property.rgbValue
        let alpha = property.alpha
        buttonSetRandomColor.backgroundColor = UIColor(
            red: color.r/255,
            green: color.g/255,
            blue: color.b/255,
            alpha: alpha/10
        )
        sliderSetAlpha.setValue(Float(alpha), animated: true)
    }
    
    func admitDefault() {
        buttonSetRandomColor.backgroundColor = defaultButtonColor
        sliderSetAlpha.setValue(0, animated: true)
    }
}
