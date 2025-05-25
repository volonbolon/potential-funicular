//
//  DetailInteractor.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 25/05/2025.
//

import Foundation

class DetailInteractor {
    private var stockService: StockServiceProtocol
    init() {
        let manager = SwiftDataContextManager.shared
        guard let container = manager.container, let context = manager.context else {
            fatalError()
        }
        stockService = StockService(container: container, context: context)
    }
    
    func findSelected() -> Stock? {
        return stockService.selected()
    }
}
