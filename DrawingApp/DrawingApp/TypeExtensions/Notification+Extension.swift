//
//  Notification+Extension.swift
//  DrawingApp
//
//  Created by 백상휘 on 2022/03/08.
//

import UIKit

// MARK: - Predifined Notification Names
extension Notification.Name {
    /// Notification name MainScreen(Rectangle etc...) touched
    static let MainScreenTouched = Notification.Name(rawValue: "MainScreenTouched")
    /// Notification name MainScreenControl(AddButton, AlphaSlider, ColorButton etc...) touched
    static let MainScreenAction = Notification.Name(rawValue: "MainScreenAction")
}

// MARK: - Add Observer Each ViewControllers
extension MainScreenViewController {
    // handler를 호출하는 쪽에서 정의하도록 한 이유는 아래의 함수가 호출하는 쪽의 응집력을 뺏어간다고 판단했기 때문입니다.
    func observeMainScreenAction(using handler: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(
            forName: .MainScreenAction,
            object: nil,
            queue: OperationQueue.main,
            using: handler
        )
    }
}

extension ViewController {
    // 위의 observeMainScreenAction(using: (Notification)->Void) 의 설명과 같이 응집력의 문제를 생각하여 handler를 전달받습니다.
    func observeMainScreenTouched(using handler: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(
            forName: .MainScreenTouched,
            object: nil,
            queue: OperationQueue.main,
            using: handler
        )
    }
}
