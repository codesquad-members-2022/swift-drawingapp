//
//  Log.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/02.
//

import Foundation
import OSLog

enum Log {
    static func info(_ message: String) {
        Logger().info("\(message, privacy: .public)")
    }
}
