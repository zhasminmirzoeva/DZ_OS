//
//  Scanner.swift
//  ExDate
//
//  Created by Zhasmin Mirzoeva on 16/04/24.
//

import AVFoundation
import SwiftUI
struct Scanner: UIViewControllerRepresentable {
    @Binding var code: String?
    @Binding var supportBarcode: [CodeType]
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: Scanner
        
        init(parent: Scanner) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                
                DispatchQueue.main.async {
                    self.parent.code = stringValue
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        
        let session = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: .video) else { return vc }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        } catch {
            return vc
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
        output.metadataObjectTypes = supportBarcode.map { $0.rawValue }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = vc.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        vc.view.layer.addSublayer(previewLayer)
        
        session.startRunning()
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
