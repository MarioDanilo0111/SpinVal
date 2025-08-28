//
//  VisionOCR.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-27.
//

import UIKit
import Vision

enum VisionOCR {
    static func recognizeText(in image: UIImage, completion: @escaping([String]) -> Void) {
        guard let cgImage = image.cgImage else {
            completion([]); return
        }
        
        let request = VNRecognizeTextRequest {request, error in
            let result = (request.results as? [VNRecognizedTextObservation]) ?? []
            let lines = result.compactMap {$0.topCandidates(1).first?.string}
            DispatchQueue.main.async {completion(lines)}
        }
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {try handler.perform([request])}
            catch {DispatchQueue.main.async {completion([])}}
        }
    }
    
}
