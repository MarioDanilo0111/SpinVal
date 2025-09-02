//
//  ProviderError.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-31.
//

import Foundation

public enum ProviderError: Error, Equatable, LocalizedError {
    case networkUnavailable
    case requestFailed(statusCode: Int?)
    case decodingFailed
    case rateLimited(retryAfter: Date?)
    case unauthorized
    case notFound
    case invalidQuery
    case timeout
    case unknown
    
    
    // Keep text short; friendly UI copy comes later.
    public var errorDescription: String? {
        switch self{
        case .networkUnavailable:  return "Network unavailable."
        case .requestFailed: return "Request failed."
        case .decodingFailed: return "Decoding failed."
        case .rateLimited: return "Rate limited."
        case .unauthorized: return "Unauthorized"
        case .notFound: return "Not found."
        case .invalidQuery: return "Invalid query."
        case .timeout: return "Request time out."      
        case .unknown: return "Unknown error."
        }
    }
    
}
