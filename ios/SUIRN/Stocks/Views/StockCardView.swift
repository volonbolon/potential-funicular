//
//  StockCardView.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import SwiftUI

struct StockCardView: View {
    var stock: Stock
    var body: some View {
        VStack(alignment: .leading) {
            Text(stock.name)
                .font(.headline)
            Text("\(stock.ticker)")
                .font(.caption)
        }
    }
}
