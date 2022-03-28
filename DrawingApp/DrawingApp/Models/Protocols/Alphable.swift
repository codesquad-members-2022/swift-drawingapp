//
//  Alphable.swift
//  DrawingApp
//
//  Created by 김상혁 on 2022/03/14.
//

import Foundation

protocol Alphable {
    var alpha: Alpha { get }
    
    func canAlphaLevelUp() -> Bool
    func canAlphaLevelDown() -> Bool
    func upAlphaLevel()
    func downAlphaLevel()
}
