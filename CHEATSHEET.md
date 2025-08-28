# SpinVal - iOS Recipes

## Camera (AVFoundation)

Session -> Device -> Input -> PreviewLayer -> Delegate

- Configurate: beginConfiguration/commit
- Input: AVCaptureDevice.default + AVCaptureDeviceInput
- Output: AVCapturePhotoOutput + capturePhoto(delegate:)
- UI: AVCaptureVideoPreviewLayer in UIViewRepresentable

## OCR (Vision)

Image -> VNRecognizeTextRequest -> VNImageRequestHandler.perform -> Observations

- Results: [VNRecognizedTextObservation] -> topCandidates(1).first?.string

## SwiftUI

- Views reder @Published state from services (ObservableObject)
- Work pff main: UI updates on main

Hotkeys: ⌥-click (Quick Help), ⇧⌘K (Clean), ⌘B (Build), ⌘R (Run)
