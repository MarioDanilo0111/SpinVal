//
//  YourAPIPriceProvider.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-09-04.
//

import Foundation

struct YourAPIPriceProvider: PriceProvider {
    func priceBand(catalogNumber: String) async throws -> PriceBand {
        fatalError("not implemented")
    }
}
