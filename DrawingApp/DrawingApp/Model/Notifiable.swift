//
//  Notifiable.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/18.
//

import Foundation

enum NotificationKey {
    case created
    case updated
}

protocol Notifiable: AnyObject {
    func notifyDidCreated()
    func notifyDidUpdate(key: NotificationKey, data: Any)
}
