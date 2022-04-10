//
//  OptionalExtension.swift
//  ResumeBuilder
//
//  Created by Methas Tariya on 10/4/22.
//  Copyright © 2022 Methas Tariya. All rights reserved.
//

import Foundation

extension Optional {
    var isNil: Bool { self == nil }
    var isNotNil: Bool { self != nil }
    
    func or(_ other: @autoclosure () throws -> Wrapped?) rethrows -> Wrapped? {
        switch self {
        case .some(let value):
            return value
        case .none:
            return try other()
        }
    }
    
    func or(_ other: @autoclosure () throws -> Wrapped) rethrows -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            return try other()
        }
    }
}
