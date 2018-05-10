//
//  SocketManager.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 9..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import SocketIO
import Foundation

class WebSocketManager: NSObject {
    
    // MARK: - Propertise
    internal let socketManager: WebSocketManager = WebSocketManager()
    private var webSocket: SocketIOClient?
    
    // MARK: - System Method
    private override init() {}
    
    // MARK: - Method
    internal func connectServer(url: String) {
        
        if let serverURL: URL = URL(string: url) {
            let socketManager: SocketManager = SocketManager(socketURL: serverURL, config: [.log(true), .compress])
            webSocket = socketManager.defaultSocket
            
            webSocket?.on(clientEvent: .connect, callback: { (data, ack) in
                print("- Connected to Web Socket Server.")
            })
            
            webSocket?.on("Message", callback: { (data, ack) in
                
            })
            
            webSocket?.connect()
        }
    }
    
    internal func sendServer(event: String, datas: [String]) {
        webSocket?.emit(event, datas)
    }
}
