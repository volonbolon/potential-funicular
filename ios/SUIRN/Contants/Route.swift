//
//  Route.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

// This implementation defines a type-safe way to handle
// different navigation destinations within an application

enum Route {
    case home
    case details(stock: Stock)
    case legal
}

extension Route: Hashable {}
