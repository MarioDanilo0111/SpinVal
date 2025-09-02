//
//  ReleaseModels.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-31.
//
import Foundation

public typealias ReleaseID = String

public struct Release: Codable, Hashable, Sendable {
    public let id: ReleaseID
    public let artist: String
    public let title: String
    public let year: Int?
    public let label: String?
    public let catalogNumber: String?
    public let barcode: String?
 
    
    public init (
    id: ReleaseID,
    artist: String,
    title: String,
    year: Int? = nil,
    label: String? = nil,
    catalogNumber: String? = nil,
    barcode: String? = nil,
    ){
        self.id = id
        self.artist = artist
        self.title = title
        self.year = year
        self.label = label
        self.catalogNumber = catalogNumber
        self.barcode = barcode
        
    }
}

/// A matched release plus a confidence score in the range 0.0 -1.0.
public struct ReleaseMatch: Codable, Hashable, Sendable {
    public let release: Release
    /// Confidence in [0.0, 1.0]. Callers should ensure the range.
    public let confidence: Double
    
    public init(release: Release, confidence: Double) {
        self.release = release
        self.confidence = confidence
    }
}
