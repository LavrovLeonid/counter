//
//  History.swift
//  Counter
//
//  Created by Леонид Лавров on 2/26/24.
//

import Foundation

class History: HistoryProtocol {
    private var history: [Item] = []
    
    func appendHistory(_ item: Item) {
        history.append(item)
    }
    
    func getHistoryDisplayText() -> String {
        history.reduce("") { partialResult, historyItem in
            partialResult + historyItem.getDisplayText()
        }
    }
}
