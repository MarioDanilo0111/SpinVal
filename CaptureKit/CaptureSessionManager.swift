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

    func configure(){
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
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
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
                    self.ocrText = lines.joined(separator: "\n")
                    
                }
            }
        }
            
    }
}
