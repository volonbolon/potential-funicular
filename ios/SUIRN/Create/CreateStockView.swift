//
//  CreateStockView.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import SwiftUI

struct CreateStockView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var ticker: String = ""
    @State private var name: String = ""
    @State private var price: String = ""
    
    private var presenter: CreateStockPresenter
    
    init(presenter: CreateStockPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        NavigationStack {
            Section(content: {
                Form {
                    TextField("Ticker", text: $ticker)
                    TextField("Name", text: $name)
                    TextField("Current Price", text: $price)
                        .keyboardType(.numberPad)
                }
            })
            Section(
                content: {
                    Button {
                        if ticker.isEmpty || name.isEmpty || price.isEmpty {
                            return
                        }
                        guard let priceAsDouble = Double(price) else {
                            return
                        }
                        presenter.createStock(
                            ticker: ticker,
                            name: name,
                            price: priceAsDouble
                        )
                        dismiss()
                } label: {
                    Text("Save")
                }
            })
            .navigationTitle("New Stock")
        }
    }
}
