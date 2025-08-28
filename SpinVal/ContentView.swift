//
//  ContentView.swift
//  SpinVal
//
//  Created by Mario Fernandez on 2025-08-24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var camera = CaptureSessionManager()
    @State private var cameraAllowed = false
    
    var body: some View {
        ZStack {
            if cameraAllowed, camera.isConfigured {
                CameraPreview(session: camera.session)
                    .ignoresSafeArea()
            }else{
                Text(cameraAllowed ? "Configuring camera" : "Requesting camera...")
            }
            
            
            //Thumbnail (top-right)
            if let img = camera.lastPhoto {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(.white.opacity(0.6), lineWidth: 1))
                    .shadow(radius: 4)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            
            if !camera.ocrText.isEmpty {
                Text(camera.ocrText)
                    .font(.system(size:14, weight: .medium, design: .monospaced))
                    .lineLimit(4)
                    .padding(12)
                    .background(.black.opacity(0.6))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
            
            //Capture button (button-center)
            VStack {
                Spacer()
                Button {
                    camera.capturePhoto()
                } label: {
                    ZStack {
                        Circle().frame(width: 78,height: 78).opacity(0.2)
                        Circle().frame(width: 64, height: 64)
                            .overlay(Circle().stroke(.white, lineWidth: 3))
                    }
                }
                .padding(.bottom, 24)
            }
        }
        
        
        .onAppear {
            CameraPermissions.requestIfNeeded { gradient in
                cameraAllowed = gradient
                if gradient{
                    camera.configure()
                    camera.start()
                }
            }
        }
        .onDisappear{
            camera.stop()
        }
    }
}
