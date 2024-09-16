//
//  CounterTypes.swift
//  Counter
//
//  Created by Леонид Лавров on 2/22/24.
//

import Foundation

enum CountActionType {
    case initial
    case increment
    case decrement
    case minOverload
    case reset
}

protocol CounterDelegate {
    func counterDidChange()
}

protocol CounterProtocol {
    static var initialValue: Int { get }

    var delegate: CounterDelegate? { get set }
    var countDisplayText: String { get }
    
    func increment()
    func decrement()
    func reset()
}

protocol CounterHistorItemProtocol: HistoryItem {
    var type: CountActionType { get }
    var date: Date { get }
}
