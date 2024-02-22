//
//  CounterTypes.swift
//  Counter
//
//  Created by Леонид Лавров on 2/22/24.
//

import Foundation

enum CountType {
    case initial
    case increment
    case decrement
    case minOverload
    case reset
}

protocol CounterProtocol {
    static var initialValue: Int { get }

    var countDisplayText: String { get }
    
    mutating func increment()
    mutating func decrement()
    mutating func reset()
}

protocol CounterHistoryProtocol {
    func getHistoryDisplayText() -> String
}
