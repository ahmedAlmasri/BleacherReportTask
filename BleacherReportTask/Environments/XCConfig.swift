//
//  XCConfig.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import Foundation

@propertyWrapper
public struct XcodeConfig<Value: LosslessStringConvertible> {
    
    private let key: String
    private let bundle: Bundle
    public var wrappedValue: Value { value(for: key) }
    
    public init(key: String, bundle: Bundle = .main) {
        self.key = key
        self.bundle = bundle
    }
    
    private func value(for key: String) -> Value {
        guard let object = bundle.object(forInfoDictionaryKey: key) else {
            fatalError("Missing key: \(key)")
        }
        
        switch object {
            case let value as Value:
                return value
                
            case let string as String:
                guard let value = Value(string) else { fallthrough }
                return value
                
            default:
                fatalError("Invalid Value")
        }
    }
}
