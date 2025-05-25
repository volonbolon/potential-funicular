//
//  StocksModule.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 24/05/2025.
//

import Foundation

@objc(StocksModule)
class StocksModule: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc
    static func getValues(_ n: Int, ticker: String) -> [[AnyHashable: Any]] {
        let manager = SwiftDataContextManager.shared
        guard let container = manager.container, let context = manager.context else {
            fatalError()
        }
        let stockService = StockService(container: container, context: context)
        let stock = stockService.findStock(ticker: ticker);
        
        switch n {
        case 0:
            return stock?.lastSevenDays() ?? []
        case 1:
            return stock?.lastMonth() ?? []
        case 2:
            return stock?.lastYear() ?? []
        default:
            return []
        }
    }
}
