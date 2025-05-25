//
//  StockService.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//
import Combine
import Foundation
import SwiftData

class SubjectWrapper {
    static let stocksSubject = CurrentValueSubject<[Stock], Never>([])
    
    static let shared = SubjectWrapper()
}

protocol StockServiceProtocol {
    static var stocksSubject: CurrentValueSubject<[Stock], Never> { get }
    
    func loadStocks() async
    func insertStock(_ stock: Stock) async
    func findStock(ticker: String) -> Stock?
    func setSelected(_ stock: Stock)
    func selected() -> Stock?
}

class StockService: StockServiceProtocol {
    private let container: ModelContainer
    private let context: ModelContext
    
    private let subjectWrapper = SubjectWrapper.shared
    
    static let stocksSubject: CurrentValueSubject<[Stock], Never> = CurrentValueSubject<[Stock], Never>([])
    
    init(container: ModelContainer, context: ModelContext) {
        self.container = container
        self.context = context
        #if DEBUG
        loadCannedStocks()
        #endif
    }
    
#if DEBUG
    private func loadCannedStocks() {
        let fetchDescriptor = FetchDescriptor<Stock>()
        guard let entities = try? context.fetch(fetchDescriptor) else { return }
        if entities.isEmpty {
            Stock.stocks.forEach { stock in
                context.insert(stock)
            }
            try? context.save()
        }
    }
#endif

    func loadStocks() {
        let fetchDescriptor = FetchDescriptor<Stock>()
        guard let entities = try? context.fetch(fetchDescriptor) else { return }
        StockService.stocksSubject.send(entities)
    }
    
    func insertStock(_ stock: Stock) {
        context.insert(stock)
        loadStocks()
    }
    
    func findStock(ticker: String) -> Stock? {
        let predicate = #Predicate<Stock> { $0.ticker == ticker }
        var fetchDescriptor = FetchDescriptor<Stock>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        guard let entities = try? context.fetch(fetchDescriptor) else { return nil }
        return entities.first
    }
    
    func setSelected(_ stock: Stock) {
        let predicate = #Predicate<Stock> { $0.selected == true }
        let fetchDescriptor = FetchDescriptor<Stock>(predicate: predicate)
        let selected = try? context.fetch(fetchDescriptor)
        selected?.forEach { $0.selected = false }
        stock.selected = true
        try? context.save()
    }
    
    func selected() -> Stock? {
        let predicate = #Predicate<Stock> { $0.selected == true }
        var fetchDescriptor = FetchDescriptor<Stock>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        let selected = try? context.fetch(fetchDescriptor)
        return selected?.first
    }
}

