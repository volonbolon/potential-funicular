//
//  StocksView.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import SwiftUI

struct StocksView: View {
    @StateObject var presenter: StocksPresenter = StocksPresenter()
    var body: some View {
        NavigationStack(path: $presenter.path) {
            List(content: {
                Section(header: Text("Stocks")) {
                    ForEach(presenter.stocks, id: \.ticker) { stock in
                        StockCardView(stock: stock)
                            .onTapGesture {
                                presenter.navigate(to: .details(stock: stock))
                            }
                    }
                }
                Section(header: Text("Legal")) {
                    Text("Terms and Conditions")
                        .onTapGesture {
                            presenter.navigate(to: .legal)
                        }
                }
            })
            .navigationDestination(for: Route.self) { route in
                presenter.destinationFor(route)
            }
            .toolbar {
                Button(action: {
                    presenter.presentCreateForm()
                }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $presenter.isPresentingCreateForm, content: {
                presenter.newStockForm()
            })
        }
        .task {
            await presenter.loadStocks()
        }
    }
}

#Preview {
    StocksView()
}
