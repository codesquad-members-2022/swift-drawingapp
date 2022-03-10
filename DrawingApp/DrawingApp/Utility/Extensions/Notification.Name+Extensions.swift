//
//  Notification.Name+Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/09.
//

import Foundation

/**
 프로젝트의 규모가 작아 Notification.Name 를 직접 확장하는 방식으로
 커스텀 Notification.Name 을 추가하였습니다.
 이벤트의 종류가 늘어나면 도메인 별로 enum 으로 묶어 분리하여 관리 방법을 시도해보겠습니다.
 */
extension Notification.Name {
    static let RectangleDataDidCreated = Notification.Name("RectangleDataDidCreated")
    static let RectangleDataDidUpdated = Notification.Name("RectangleDataDidUpdated")
    
    static let PlaneDidSelectItem = Notification.Name("PlaneDidSelectItem")
    static let PlaneDidUnselectItem = Notification.Name("PlaneDidUnselectItem")
}
