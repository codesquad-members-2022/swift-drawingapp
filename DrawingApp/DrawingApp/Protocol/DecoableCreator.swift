//
//  DecoableComponentCreate.swift
//  DrawingApp
//
//  Created by 박진섭 on 2022/03/02.
//

protocol DecoableCreator {
    func makeRandomDecoable(decoType:DecoType) -> Decoable
}
