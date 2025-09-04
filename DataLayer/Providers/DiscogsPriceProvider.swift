//
//  DiscogsPriceProvider.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-09-04.
//
import Foundation

struct DiscogsPriceProvider: PriceProvider {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func priceBand(catalogNumber: String) async throws -> PriceBand {
        fatalError("not implemented")
    }
    
    // Optional later:
    // func priceBand(barcode: String) async throw -> PriceBand { fatalError ("not implemented") }
}
