//
//  Stock.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import Foundation
import SwiftData

@Model
class Stock {
    @Attribute(.unique) var ticker: String
    var name: String
    var price: Double
    var timestamp: Date
    var selected: Bool = false
    
    init(ticker: String, name: String, price: Double) {
        self.ticker = ticker
        self.name = name
        self.price = price
        self.timestamp = .now
    }
}

extension Stock: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(ticker): \(name) (\(selected ? "selected" : "not selected"))"
    }
}

// MARK: - Helpers
extension Stock {
    func lastSevenDays() -> [[String: Any]] {
        let price = self.price
        let delta = (price * 1.05)
        let min = max(price - delta, 0)
        let max = price + delta
        let values: [[String: Any]] = (1...7)
            .map( {v in ["day":v, "price": Double.random(in: min...max)]} )
        return values
    }
    
    func lastMonth() -> [[String: Any]] {
        let price = self.price
        let delta = (price * 1.15)
        let min = max(price - delta, 0)
        let max = price + delta
        let values: [[String: Any]] = (1...15)
            .map( {v in ["day":v, "price": Double.random(in: min...max)]} )
        return values
    }
    
    func lastYear() -> [[String: Any]] {
        let price = self.price
        let delta = (price * 1.25)
        let min = max(price - delta, 0)
        let max = price + delta
        let values: [[String: Any]] = (1...60)
            .map( {v in ["day":v, "price": Double.random(in: min...max)]} )
        
        return values
    }
}

#if DEBUG
// This is just to have some data to mock funcs
extension Stock {
    static let stocks: [Stock] = [
        .init(ticker: "NVDA", name: "NVIDIA Corporation", price: 131.24),
        .init(ticker: "INTC", name: "Intel Corporation", price: 20.03),
        .init(ticker: "PLTR", name: "Palantir Technologies Inc", price: 122.94)
    ]
}
#endif
