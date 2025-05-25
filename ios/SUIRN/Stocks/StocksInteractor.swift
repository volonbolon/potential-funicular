//
//  StockInteractor.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import Foundation
import Combine

class StocksInteractor {
    @Published var stocks: [Stock] = []
    
    var stockService: StockServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        let manager = SwiftDataContextManager.shared
        guard let container = manager.container, let context = manager.context else {
            fatalError()
        }
        stockService = StockService(container: container, context: context)
        
        StockService.stocksSubject
            .receive(on: DispatchQueue.main)
            .sink { stocks in
                self.stocks = stocks
            }
            .store(in: &cancellables)
    }
    
    func loadStocks() async {
        await stockService.loadStocks()
    }
    
    func setSelected(_ stock: Stock) {
        stockService.setSelected(stock)
    }
}

extension StocksInteractor: ObservableObject {}
