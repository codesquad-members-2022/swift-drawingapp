//
//  Gallery.swift
//  DrawingApp
//
//  Created by 송태환 on 2022/03/11.
//

import Foundation

struct Gallery {
    private var items = [URL: Data]()
    
    var count: Int {
        return items.count
    }
    
    subscript(url url: URL) -> Data? {
        get {
            return self.items[url]
        }
        set {
            guard self.items[url] == nil else { return }
            self.items[url] = newValue
        }
    }
}
