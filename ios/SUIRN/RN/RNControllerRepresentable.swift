//
//  RNControllerRepresentable.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 25/05/2025.
//

import SwiftUI

struct RNControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ReactViewController
    
    let stock: Stock
    
    init(stock: Stock) {
        self.stock = stock
    }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let vc = ReactViewController()
        vc.stock = stock
        return vc
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {}
}
