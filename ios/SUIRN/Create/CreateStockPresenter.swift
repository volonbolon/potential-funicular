//
//  CreateStockPresenter.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import Combine

class CreateStockPresenter {
    private let interactor: CreateStockInteractor
    
    init(interactor: CreateStockInteractor) {
        self.interactor = interactor
    }
    
    func createStock(ticker: String, name: String, price: Double) {
        let stock = Stock(
            ticker: ticker,
            name: name,
            price: price
        )
        Task {
            await interactor.createStock(stock: stock)
        }
    }
}
