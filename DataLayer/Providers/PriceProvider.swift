//
//  PriceProvider.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-31.
//

import Foundation

/// Contract for anything that can provide a price band for a release.
protocol PriceProvider {
    /// Estimate price band primarily via catalog number (MVP path)
    func priceBand(catalogNumber: String) async throws -> PriceBand
    
    /// Optional late: price bu barcode route (keep signature now for clarity; implement late if useful)
    ///  func priceBand(barcode: String) async throws -> PriceBand
}
