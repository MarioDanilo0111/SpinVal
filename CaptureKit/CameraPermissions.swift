import AVFoundation


enum CameraPermissions {
    static func requestIfNeeded(_ onResult: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: onResult(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async { onResult(granted) }
                
            }
        default: onResult(false)
        }
    }
}
