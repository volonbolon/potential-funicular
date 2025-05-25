//
//  SwiftDataContextManager.swift
//  SUIRN
//
//  Created by Ariel Rodriguez on 23/05/2025.
//

import Foundation
import SwiftData

class SwiftDataContextManager{
    // Singleton
    static let shared = SwiftDataContextManager()
    
    var container: ModelContainer?
    var context : ModelContext?
    
    private init() {
        do {
            container = try ModelContainer(for: Stock.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
