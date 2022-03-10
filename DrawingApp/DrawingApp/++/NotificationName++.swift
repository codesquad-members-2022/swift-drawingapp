//
//  NotificationName++.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/11.
//

import Foundation
//Notification Name입력시 오류를 줄이고자 static let으로 각 Notification의 이름을 넣었습니다.
extension Notification.Name {
    static let changeAlpha = Notification.Name("changeAlpha")
    static let changeColor = Notification.Name("Color")
    static let addRectangle = Notification.Name("addRectangle")
    static let findseletedRectangle = Notification.Name("findseletedRectangle")
}
