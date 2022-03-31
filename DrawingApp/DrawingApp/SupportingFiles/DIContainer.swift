//
//  DIContainer.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/31.
//

import Foundation

typealias FactoryClosure = (DIContainer) -> AnyObject

protocol DIContainable {
    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure)
    func resolve<Service>(type: Service.Type) -> Service?
}

class DIContainer: DIContainable {
    var services = Dictionary<String, FactoryClosure>()
    
    func register<Service>(type: Service.Type, factoryClosure: @escaping FactoryClosure) {
        services["\(type)"] = factoryClosure
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"]?(self) as? Service
    }
}

