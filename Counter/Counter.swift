//
//  Counter.swift
//  Counter
//
//  Created by Леонид Лавров on 2/22/24.
//

import Foundation

struct CounterHistoryItem {
    let type: CountType
    let date: Date
    
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

struct Counter: CounterProtocol, CounterHistoryProtocol {
    // MARK: Static properties
    
    static var initialValue: Int = 0
    
    // MARK: Private properties
    
    private var history: [CounterHistoryItem] = [CounterHistoryItem(type: .initial, date: Date())]
    private var count: Int = Counter.initialValue
    private var minValue: Int = 0
    
    // MARK: Computed properties
    
    var countDisplayText: String {
        "Значение счётчика: \(count)"
    }
    
    // MARK: Private API
    
    private mutating func changeCount(type: CountType, changeOn: Int) {
        let date = Date()
        var tempCount = count
        var counterHistoryItem = CounterHistoryItem(type: type, date: date)
        
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

            counterHistoryItem = CounterHistoryItem(type: .minOverload, date: date)
        }
        
        self.count = tempCount
        self.history.append(counterHistoryItem)
    }
    
    // MARK: Public API
    
    mutating func increment() {
        changeCount(type: .increment, changeOn: 1)
    }
    
    mutating func decrement() {
        changeCount(type: .decrement, changeOn: 1)
    }
    
    mutating func reset() {
        changeCount(type: .reset, changeOn: Counter.initialValue)
    }
    
    func getHistoryDisplayText() -> String {
        history.reduce("") { partialResult, historyItem in
            partialResult + historyItem.getDisplayText()
        }
    }
}
