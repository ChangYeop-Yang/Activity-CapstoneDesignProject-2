//
//  DownloadManager.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 22..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import CoreML
import Vision

class DownloadManager: NSObject {
    
    // MARK: - Variables
    internal static let downloadManager: DownloadManager = DownloadManager()
    
    private override init() {}
    
    // MARK: - Method
    private func detectFace(image: UIImage) -> Int {
        
        var faceCount: Int = 0
        
        if let cgimage = image.cgImage {
            let requestVN = VNDetectFaceRectanglesRequest { request, error in
                
                guard let result = request.results as? [VNFaceObservation], error == nil else {
                    fatalError("- Occur error detect face image. \(String(describing: error?.localizedDescription))")
                }
                
                faceCount = result.count
            }
            
            try? VNImageRequestHandler(cgImage: cgimage).perform([requestVN])
        }
        
        return faceCount
        
    }
    private func detectObject(data: Data) -> String? {
        
        var detectedObjects: String?
        
        if let model: VNCoreMLModel = try? VNCoreMLModel(for: MobileNet().model) {
            
            let requestVN = VNCoreMLRequest(model: model) { request, error in
                
                guard let finishedRequest = request.results as? [VNClassificationObservation], let topResult = finishedRequest.first else {
                    fatalError("- Unexpected result type from VNCoreMLRequest.")
                }
                
                detectedObjects = topResult.identifier
            }
            
            try? VNImageRequestHandler(data: data).perform([requestVN])
        }
        
        return detectedObjects
    }
    internal func downloadImage(url: String) {
        
        if let link: URL = URL(string: url) {
            DispatchQueue.main.async(execute: { [unowned self] in
                if let data = try? Data(contentsOf: link), let image: UIImage = UIImage(data: data) {
                    
                    // Detected Object
                    if let objectNames: String = self.detectObject(data: data) {
                        print("- The Objects have been detected. \(objectNames)")
                        
                        if UIApplication.shared.applicationState == .active {
                            showWhisperToast(title: "Detected \(objectNames) object.", background: .maroon, textColor: .white, clock: 10)
                        }
                    }
                    
                    // Detected Person
                    let peopleCount: Int = self.detectFace(image: image)
                    if peopleCount > 0 {
                        print("- A person has been detected. \(peopleCount)")
                        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
                        
                        if UIApplication.shared.applicationState == .active {
                            showWhisperToast(title: "Detected \(peopleCount) peoples.", background: .maroon, textColor: .white, clock: 10)
                        }
                    }
                }
            })
        }
    }
}
