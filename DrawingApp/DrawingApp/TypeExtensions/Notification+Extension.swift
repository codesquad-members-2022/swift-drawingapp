//
//  Notification+Extension.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/08.
//

import UIKit

// ViewController는 Rectangle이 선택되면 그 모델을 전달받아다가 버튼, 슬라이더에 적용하고
// 버튼이 눌리거나 슬라이더가 움직이면 그 신호를 Plane -> MainScreenViewController에 보내게 된다.
extension Notification.Name {
    // MainScreenViewController -> Plane -> ViewController
    static let MainScreenTouched = Notification.Name(rawValue: "MainScreenTouched")
    // ViewController -> Plane -> MainScreenViewController
    static let MainScreenAction = Notification.Name(rawValue: "MainScreenAction")
}
