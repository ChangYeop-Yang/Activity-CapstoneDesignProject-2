//
//  LiveCamera.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 18..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import AudioToolbox
import Whisper

class LiveCamera: UIView {
    
    // MARK: - Outlet Variables
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // setting View layout
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        
        // load Web View
        loadWebView(url: "http://172.30.1.2:8080/stream")
    }
    
    // MARK: - Method
    private func loadWebView(url: String) {
        
        if let link: URL = URL(string: url) {
            webView.delegate = self
            webView.allowsInlineMediaPlayback = true
            webView.allowsPictureInPictureMediaPlayback = true
            webView.loadRequest(URLRequest(url: link))
        }
    }
    
    // MARK: - Action Method
    @IBAction func capturePhoto(_ sender: UIButton) {
        
        // Wisper
        showWhisperToast(title: "Camera video screenshot", background: .moss, textColor: .white)
        
        UIGraphicsBeginImageContext(webView.frame.size)
        webView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    
    @IBAction func cancelGesture(_ sender: UILongPressGestureRecognizer) {
        self.removeFromSuperview()
    }
}

// Extension UIWebView Delegate
extension LiveCamera: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.indicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.indicator.stopAnimating()
    }
}
