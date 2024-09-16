//
//  HistoryTypes.swift
//  Counter
//
//  Created by Леонид Лавров on 2/26/24.
//

import Foundation

protocol HistoryItem {
    func getDisplayText() -> String
}

protocol HistoryProtocol {
    typealias Item = HistoryItem
    
    func appendHistory(_ item: Item)
    func clearHistory()
    func getHistoryDisplayText() -> String
}
