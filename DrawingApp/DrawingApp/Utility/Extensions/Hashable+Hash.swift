//
//  Hashable+Hash.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/10.
//

import Foundation

/**
 클래스의 Hashable 프로토콜 채택 시 편의를 제공하기 위해 기본 구현체를 추가하였습니다.
 유니크한 해쉬값을 위해 ObjectIdentifier 를 해쉬 인자로 사용했습니다.
 Hashable 프로토콜이 Equatable 을 상속하고 있다는 점을 참고해
 static func == (lhs: Self, rhs: Self) -> Bool 함수도 함께 기본 구현체를 추가했습니다.
 */
extension Hashable where Self: AnyObject {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs === rhs
    }
}
