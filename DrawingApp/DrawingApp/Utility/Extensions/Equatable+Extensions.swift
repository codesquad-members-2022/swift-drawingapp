//
//  Equatable+Extensions.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/10.
//

import Foundation

/**
 Hashable 과 같은 맥락으로 클래스에서 채택 시 편의성을 제공할 목적을 가집니다.
 또한 Hashable 은 Equatable 을 상속하므로 아래의 구현체도 동시에 제공할 수 있는 장점이 있습니다.
 */
extension Equatable where Self: AnyObject {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs === rhs
    }
}
