//
//  NotificationKey.swift
//  drawingApp
//
//  Created by Kai Kim on 2022/03/14.
//

import Foundation

enum UserInfo  {
    case model
    case previousModel
    case currentModel
}

extension Notification.Name {
    //Define unique identifier for notification and make them as a type variable. 
    static let DidMakeModel = Notification.Name("Kai.drawingApp.makeModel")
    static let DidChangeColor = Notification.Name("Kai.drawingApp.changeColor")
    static let DidChangeAlpha = Notification.Name("Kai.drawingApp.changeAlpha")
}

