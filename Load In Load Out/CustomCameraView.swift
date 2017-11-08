//
//  CustomCameraView.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 11/7/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import AVFoundation

class CustomCameraView : UIView, AVCaptureMetadataOutputObjectsDelegate {
    
    // Variables
    var video = AVCaptureVideoPreviewLayer()

    func presentCamera() {
        
        // Creating Session
        let session = AVCaptureSession()
        
        // Define Capture Device
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            print("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = self.bounds
        video.masksToBounds = true
        self.layer.addSublayer(video)
        
        session.startRunning()
        
    }
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    
                    
                    
                }
            }
        }
        
    }
    
}





























