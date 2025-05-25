//
//  StockPresenter.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import Combine
import SwiftUI

class StocksPresenter {
    private let interactor: StocksInteractor = StocksInteractor()
    private var cancellables: Set<AnyCancellable> = []
    private let router = StocksRouter()
    
    @Published var stocks: [Stock] = []
    @Published var path = NavigationPath()
    
    @Published var isPresentingCreateForm: Bool = false
    
    init() {
        interactor.$stocks
            .sink(receiveValue: { stocks in
                self.stocks = stocks
            })
            .store(in: &cancellables)
    }
    
    func loadStocks() async {
        await interactor.loadStocks()
    }
    
    func navigate(to route: Route) {
        router.navigate(to: route, path: &path)
    }
    
    func destinationFor(_ route: Route) -> AnyView {
        switch route {
        case .home:
            return AnyView(StocksView())
        case .details(stock: let stock):
            interactor.setSelected(stock)
            return AnyView(DetailView())
        case .legal:
            return AnyView(Text("Legal"))
        }
    }
    
    func newStockForm() -> some View {
        let interactor = CreateStockInteractor()
        let presenter = CreateStockPresenter(interactor: interactor)
        return CreateStockView(presenter: presenter)
    }
    
    func presentCreateForm() {
        isPresentingCreateForm.toggle()
    }
}

extension StocksPresenter: ObservableObject {}
