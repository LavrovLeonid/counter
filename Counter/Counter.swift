//
//  Counter.swift
//  Counter
//
//  Created by Леонид Лавров on 2/22/24.
//

import Foundation

struct CounterHistoryItem: CounterHistorItemProtocol {
    let type: CountActionType
    let date: Date
    
    init(_ type: CountActionType) {
        self.type = type
        self.date = Date()
    }
    
    func getDisplayText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ru_RU")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let displayDate = dateFormatter.string(from: date)
        
        switch type {
        case .initial:
            return ""
        case .increment, .decrement:
            return "\(displayDate): значение изменено на -1/+1\n"
        case .minOverload:
            return "\(displayDate): попытка уменьшить значение счётчика ниже \(Counter.initialValue)\n"
        case .reset:
            return "\(displayDate): значение сброшено\n"
        }
    }
}

final class Counter: History, CounterProtocol {
    // MARK: Static properties
    
    static var initialValue: Int = 0
    
    // MARK: Private properties
    
    private var minValue: Int = 0
    private var count: Int = Counter.initialValue {
        didSet {
            delegate?.counterDidChange()
        }
    }
    
    // MARK: Properties
    
    var delegate: CounterDelegate?
    
    // MARK: Computed properties
    
    var countDisplayText: String {
        "Значение счётчика: \(count)"
    }
    
    // MARK: Private API
    
    private func changeCount(_ type: CountActionType, changeOn: Int) {
        var tempCount = count
        var counterHistoryItem = CounterHistoryItem(type)

        switch type {
        case .increment:
            tempCount += changeOn
        case .decrement:
            tempCount -= changeOn
        default:
            tempCount = changeOn
        }
        
        if tempCount < minValue {
            tempCount = minValue

            counterHistoryItem = CounterHistoryItem(.minOverload)
        }
        
        self.appendHistory(counterHistoryItem)
        self.count = tempCount
    }
    
    // MARK: Public API
    
    func increment() {
        changeCount(.increment, changeOn: 1)
    }
    
    func decrement() {
        changeCount(.decrement, changeOn: 1)
    }
    
    func reset() {
        changeCount(.reset, changeOn: Counter.initialValue)
    }
}
