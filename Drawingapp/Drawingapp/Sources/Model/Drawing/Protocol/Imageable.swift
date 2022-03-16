//
//  Imageable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol Imageable: Drawingable {
    var imageUrl: URL? { get }
    func update(imageUrl: URL?)
}
