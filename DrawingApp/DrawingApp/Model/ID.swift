//
//  ID.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/02.
//

//고유한 값을 가지는 ID는 값으로 비교해야 되기 때문에 Struct로 선언했습니다.
struct ID:CustomStringConvertible,Hashable {
    var description: String {
        "(\(firstName)-\(middleName)-\(lastName))"
    }
    
    private let firstName:String
    private let middleName:String
    private let lastName:String
    
    
    init(firstName:String, middleName:String, lastName:String) {
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
    }
}
