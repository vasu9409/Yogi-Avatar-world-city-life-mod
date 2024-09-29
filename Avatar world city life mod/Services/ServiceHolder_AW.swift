//
//  ServiceHolder.swift
//  mods-for-toca-world-4
//
//  Created by Alex N
//

import Foundation

public protocol Service_AW {}
public protocol InitializableService_AW: Service_AW {
    init()
}

public class ServiceHolder_AW {
    private var servicesDictionary: [String: Service_AW] = [:]
    
    static var shared: ServiceHolder_AW = {
        let instance = ServiceHolder_AW()
        return instance
    }()
    
    private init() {}
    
    func add_AW<T>(_ protocolType: T.Type, for instance: Service_AW) {
       
        let name = String(reflecting: protocolType)
        servicesDictionary[name] = instance
    }
    
    func get_AW<T>(by type: T.Type = T.self) -> T {
       
        return get_AW(by: String(reflecting: type))
    }
    
    private func get_AW<T>(by name: String) -> T {
       
        guard let service = servicesDictionary[name] as? T else {
            fatalError("firstly you have to add the service")
        }
        return service
    }
    
    func remove_AW<T>(by type: T.Type) {
        let name = String(reflecting: type)
        if servicesDictionary[name] as? T != nil {
            servicesDictionary[name] = nil
        }
    }
}
