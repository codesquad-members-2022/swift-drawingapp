//
//  Plane.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import Foundation

class Plane {
    
    struct Action {
        var onScreenTouched: (Point) -> Void = { _ in }
    }
    
    struct State {
        
    }
    
    var action = Action()
    var state = State()
    
    private let squares = Squares()
    
    init() {
        self.action.onScreenTouched = { point in
            print(point)
        }
    }
}
