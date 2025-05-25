//
//  StocksRouter.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import SwiftUI

class StocksRouter {
    @Published var isPresentingNewStockForm: Bool = false
    
    func navigate(to route: Route, path: inout NavigationPath) {
        path.append(route)
    }
}

extension StocksRouter: ObservableObject {}
