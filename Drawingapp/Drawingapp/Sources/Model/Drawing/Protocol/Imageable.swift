//
//  Imageable.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/03/16.
//

import Foundation

protocol Imageable: Drawingable, ImageUpdatable {
    var imageUrl: URL? { get }
}
