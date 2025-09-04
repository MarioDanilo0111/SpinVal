//
//  DiscogsReleaseProvider.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-09-04.
//

import Foundation

struct DiscogsReleaseProvider: ReleaseProvider {
    private let client: NetworkClient
    
    init(client: NetworkClient){
        self.client = client
    }
    
    func findRelease(catalogNumber: String) async throws -> [ReleaseMatch] {
        fatalError("not implemented")
    }
    
    func findRelease(barcode: String) async throws -> [ReleaseMatch] {
        fatalError("not implemented")
    }
    
    func findRelease(artist: String, title: String) async throws -> [ReleaseMatch] {
        fatalError("not implemented")
    }
}
