//
//  IDFactory.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/02.
//

final class IDFactory {
    
    static func makeRandomID() -> ID {
        let randomIdElement0 = makeIdElements()
        let randomIdElement1 = makeIdElements()
        let randomIdElement2 = makeIdElements()

        let randomID = ID(firstName: randomIdElement0, middleName: randomIdElement1, lastName: randomIdElement2)

        return randomID
    }
    
    private static func makeIdElements() -> String {
        let idSource = "abcdefghijklmnopqrstu0123456789"
        var randomIdElement = ""
        for _ in 0...2 {
            randomIdElement.append(idSource.randomElement() ?? " ")
        }
        return randomIdElement
    }
}
