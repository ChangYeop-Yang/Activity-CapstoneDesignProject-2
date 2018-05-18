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
        loadWebView(url: "https://www.youtube.com/watch?v=_Q9zha5Ebtw")
    }
    
    // MARK: - Method
    private func loadWebView(url: String) {
        
        if let link: URL = URL(string: url) {
            webView.delegate = self
            webView.allowsInlineMediaPlayback = true
            webView.allowsPictureInPictureMediaPlayback = true
            webView.loadRequest(URLRequest(url: link))
            //webView.loadHTMLString(url, baseURL: nil)
        }
    }
    
    // MARK: - Action Method
    @IBAction func capturePhoto(_ sender: UIButton) {
        
        var murMur: Murmur = Murmur(title: "Camera video screenshot")
        murMur.backgroundColor = .moss
        murMur.titleColor = .white
        murMur.font = .boldSystemFont(ofSize: 10)
        Whisper.show(whistle: murMur, action: .show(1))
        
        UIGraphicsBeginImageContext(webView.frame.size)
    }
    
    @IBAction func cancelGesture(_ sender: UILongPressGestureRecognizer) {
        self.removeFromSuperview()
    }
}

// Extension UIWebView Delegate
extension LiveCamera: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.indicator.stopAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.indicator.stopAnimating()
    }
}
