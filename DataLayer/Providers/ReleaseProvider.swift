//
//  ReleaseProvider.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-31.
//
import Foundation

///Contract for anything that can look up vinyl release metadata.
///Minimal on purpose for MVP. Implementations (Discogs, MusicBrainz, Mock) will conform to this.

protocol ReleaseProvider {
    /// Find releases  by catalog nuber (primary MVP path).
    /// - Paremeter catalogNumber: the lable's catalog code (e.g., ""XL 780", "CBS 65123")
    /// - Return:  Ranker match with confidence [0.0-1.0].
    func findRelease(catalogNumber: String) async throws -> [ReleaseMatch]
    
    /// Find releases by barcode (UPC/EAN). Some labels put a barcode on the inner label; optional path.
    func findRelease(barcode: String) async throws -> [ReleaseMatch]
    
    /// Fallback text search when we have artist+title but no catalog code.
    func findRelease(artist: String, title: String) async throws -> [ReleaseMatch]
}
