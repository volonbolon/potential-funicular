//
//  CreateStockInteractor.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

class CreateStockInteractor {
    let stockService: StockServiceProtocol

    init() {
        let manager = SwiftDataContextManager.shared
        guard let container = manager.container, let context = manager.context else {
            fatalError()
        }
        stockService = StockService(container: container, context: context)
    }
    
    func createStock(stock: Stock) async {
        await stockService.insertStock(stock)
    }
}
