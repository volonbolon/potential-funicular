//
//  DetailView.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import SwiftUI

struct DetailView: View {
    @StateObject var presenter: DetailPresenter = .init()
    
    var stock: Stock? {
        presenter.selected()
    }
    
    var body: some View {
        VStack {
            if let stock = stock {
                Text(stock.name)
            }
            
            Button {
                presenter.presentDetailView()
            } label: {
                Text("Show Sheet")
            }
        }
        .sheet(isPresented: $presenter.isPresentingChartView, content: {
            presenter.chartView()
        })
    }
}

