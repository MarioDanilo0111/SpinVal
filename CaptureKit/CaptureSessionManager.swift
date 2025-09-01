//
//  CaptureSessionManager.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-25.
//

import AVFoundation
import UIKit








final class CaptureSessionManager: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "camera.session.queue")
    private let photoOutput = AVCapturePhotoOutput()
    
    @Published var lastPhoto: UIImage?
    @Published var isConfigured = false
    @Published var lastError: String?
    @Published var ocrText: String = ""
    @Published var catalogCode: String = ""
    
    func configure() {
#if targetEnvironment(simulator)
        // Ni real camera on Simulator: mar configured so UI can proceed.
        DispatchQueue.main.async {
            self.isConfigured = true
            self.lastError = "Running on Simulator (mock camera)"
        }
        return
#endif
        
        
        sessionQueue.async {
            self.session.beginConfiguration()
            self.session.sessionPreset = .photo
            
            // Input (back wide camera)
            guard
                let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                let input = try? AVCaptureDeviceInput(device: device),
                self.session.canAddInput(input)
            else {
                self.finishConfig(error: "Camera input unavalible")
                return
            }
            self.session.addInput(input)
            
            //Output (still photos)
            guard self.session.canAddOutput(self.photoOutput) else {
                self.finishConfig(error: "Photo output unvailable")
                return
            }
            self.session.addOutput(self.photoOutput)
            
            self.session.commitConfiguration()
            DispatchQueue.main.async { self.isConfigured = true}
        }
    }
    
    func start() {
        sessionQueue.async {
            if !self.session.isRunning { self.session.startRunning() }
        }
    }
    
    func stop() {
        sessionQueue.async {
            if self.session.isRunning { self.session.stopRunning() }
        }
    }
    
    private func finishConfig(error: String) {
        self.session.commitConfiguration()
        DispatchQueue.main.async { self.lastError = error}
    }
    
    func capturePhoto() {
#if targetEnvironment(simulator)
        //Simulator fallback: make a mock image so OCR + parsing can run.
        let image = Self.mockImage(text: "TPLP123")
        DispatchQueue.main.async {
            self.lastPhoto = image
            VisionOCR.recognizeText(in: image) { lines in
                let text = lines.joined(separator:  "\n")
                self.ocrText = text
                self.catalogCode = CatalogParser.extractBast(in: text) ?? ""
                
            }
        }
        
        return
#endif
        
        
        sessionQueue.async{
            guard self.isConfigured, self.session.isRunning else{
                DispatchQueue.main.async{ self.lastError = "Capture requested before session ready." }
                return
            }
            
            let settings = AVCapturePhotoSettings()
            self.photoOutput.capturePhoto(with: settings, delegate: self)
        }
    }
    
    
    
    //MARK: Simulator helper
    private static func mockImage(text: String) -> UIImage {
        // 600x600 points; shown as a 120pt thumbnail -> scale = 120/600 = 0.2
        let size = CGSize(width: 600, height: 600)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { ctx in
            UIColor.white.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))
            
            let fontSize = min(size.width, size.height) * 0.2 // ~600pt -> 120pt (~240px @2x, 360px @3x)
            let paragraph = NSMutableParagraphStyle(); paragraph.alignment = .center
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: fontSize, weight: .bold),
                .paragraphStyle: paragraph,
                .foregroundColor: UIColor.black
            ]
            let textSize = (text as NSString).size(withAttributes: attrs)
            let rect = CGRect(
                x: (size.width - textSize.width) / 2,
                y: (size.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
                )
            
            (text as NSString).draw(
                in: rect, withAttributes: attrs)
        }
    }
    
}
        
        
        

        
        
        
extension CaptureSessionManager: AVCapturePhotoCaptureDelegate {
            func photoOutput(_ output: AVCapturePhotoOutput,
                             didFinishProcessingPhoto photo: AVCapturePhoto,
                             error: Error?){
                if let data = photo.fileDataRepresentation(),
                   let image = UIImage( data: data ) {
                    DispatchQueue.main.async { self.lastPhoto = image
                        
                        VisionOCR.recognizeText(in: image) { lines in
                            //print("OCR lines 🔜", lines.joined(separator: " | "))
                            let text = lines.joined(separator: "\n")
                            self.ocrText = text
                            self.catalogCode = CatalogParser.extractBast(in: text) ?? ""
                        }
                    }
                }
                
            }
        }
        
        
