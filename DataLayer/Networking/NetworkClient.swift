//
//  NetworkClient.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-31.
//
import Foundation

/// Minimal request shape for simple GETs.
/// `endpoint` can be a full URL or a path; we'll decide in the implementation phase.
/// `query` hold URL query items (already percent-safe keys/values).
struct NetworkRequest {
    let endpoint: String
    let query: [String: String]?
    
    init(endpoint: String, query: [String: String]? = nil) {
        self.endpoint = endpoint
        self.query = query
    }
}

/// Tiny HTTP client contract (no implementation here).
/// Implementations (e.g., URLSession-backend) will map errors late.
protocol NetworkClient {
    /// Performs a GET request and returns raw Data.
    /// Decoding helpers and error mapping come in a later step.
    func get(_ request: NetworkRequest) async throws -> Data
}
