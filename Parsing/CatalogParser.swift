//
//  CatalogParser.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-28.
//

import Foundation

enum CatalogParser {
    // Heuristics from common catalog formats like ABC-12345, TPLP123, 1234-56, etc.
    static let patterns: [NSRegularExpression] = [
        try! NSRegularExpression(pattern: #"\b[A-Z]{1,5}\s*[-/.]?\s*\d{3,7}[A-Z]?\b"#),
        try! NSRegularExpression(pattern: #"\b\d{3,5}\s*[-/.]\s*\d{1,5}\b"#),
        try! NSRegularExpression(pattern: #"\b[A-Z]{2,}\d{2,}\b"#)
    ]
    
    static func extractAll(in text: String) -> [String] {
        let up = text.uppercased()
        var results = Set<String>()
        for re in patterns {
            let matches = re.matches(in: up, range: NSRange(up.startIndex..., in: up))
            for m in matches {
                let raw = (up as NSString).substring(with: m.range)
                // Normalize remove speces, slashes, dots
                let cleaned = raw.replacingOccurrences(of: #"[\s./]"#, with: "", options: .regularExpression)
                results.insert(cleaned)
            }
        }
        return Array(results)
    }
    
    static func extractBast(in text: String) -> String? {
        let all = extractAll(in: text)
        // Naive tie-breaker: prefer mid-length codes (5-10 chars), otherwise longest
        return all.sorted {       
            let preferred = (5...10).contains($0.count) && !(5...10).contains($1.count)
            return preferred || $0.count > $1.count
        }.first
    }
}
