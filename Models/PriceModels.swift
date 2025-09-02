//
//  PriceModels.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-31.
//
import Foundation

public typealias CurrencyCode = String

public struct PriceBand: Codable, Hashable, Sendable  {
    public let low: Double
    public let median: Double
    public let high: Double
    public let currency: CurrencyCode
    public let source: String
    public let lastUpdated: Date
    
    public init (
        low: Double,
        median: Double,
        high: Double,
        currency: CurrencyCode,
        source: String,
        lastUpdated: Date,
        
    ){
        self.low = low
        self.median = median
        self.high = high
        self.currency = currency
        self.source = source
        self.lastUpdated = lastUpdated
    }
}

