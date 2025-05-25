//
//  DetailPresenter.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 25/05/2025.
//

import Foundation
import SwiftUI

class DetailPresenter {
    private var interactor: DetailInteractor
    private let router = DetailRouter()
    
    @Published var isPresentingChartView: Bool = false
    
    init() {
        self.interactor = DetailInteractor()
    }
    
    func selected() -> Stock? {
        interactor.findSelected()
    }
    
    func presentDetailView() {
        isPresentingChartView = true
    }
    
    @ViewBuilder
    func chartView() -> some View {
        if let stock = interactor.findSelected() {
            RNControllerRepresentable(stock: stock)
        } else {
            Text("No stock selected")
        }        
    }
}

extension DetailPresenter: ObservableObject {}
