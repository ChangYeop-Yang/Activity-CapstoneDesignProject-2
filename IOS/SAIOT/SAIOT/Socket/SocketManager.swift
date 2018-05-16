//
//  SocketManager.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 15..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import Foundation

// MARK: - Enum
private enum LocalMessageCategory: String {
    case Emergency = "Emergency"
    case Arduino = "Arduino"
    case Hue = "Hue"
}

class SocketManager: NSObject {
    
    // MARK: - Variables
    fileprivate var inputStream: InputStream!
    fileprivate var outputStream: OutputStream!
    internal static let socketManager: SocketManager = SocketManager()
    
    // MARK: - Method
    internal func connect(address: String, port: UInt32) -> Bool {
      
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, address as CFString, port, &readStream, &writeStream)
        
        if let read = readStream?.takeRetainedValue(), let write = writeStream?.takeRetainedValue() {
            inputStream = read
            outputStream = write
            print("- Success Connect TCP Socket Server.")
        } else {
            print("- Fail Connect TCP Socket Server.)")
            return false
        }
        
        inputStream.delegate = self
        
        inputStream.schedule(in: .current, forMode: .commonModes)
        outputStream.schedule(in: .current, forMode: .commonModes)
        
        inputStream.open()
        outputStream.open()
        
        return true
    }
    
    internal func sendData(datas: String) {
        let data = datas.data(using: .ascii)
        _ = data?.withUnsafeBytes { outputStream.write($0, maxLength: datas.count) }
    }
    
    internal func disconnect() -> Bool {
        inputStream.close()
        outputStream.close()
        print("- Success Disconnect TCP Socket Server.")
        return false
    }
    
    internal func receiveData() -> String {
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 4096)
        var bucketData: Data = Data()
        
        while inputStream.hasBytesAvailable {
            let numberOfBytesRead = inputStream.read(buffer, maxLength: 4096)
            
            if numberOfBytesRead < 0, let error = inputStream.streamError {
                print(error.localizedDescription)
            }
            
            bucketData.append(buffer, count: numberOfBytesRead)
        }
        
        return String(data: bucketData, encoding: .ascii)!
    }
}

// SocketManager Stream Extension
extension SocketManager: StreamDelegate {
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
            case Stream.Event.hasBytesAvailable:
                print("- HasBytesAvailable: new message received.")
                
                let message: String = receiveData()
                print("- Success Received data from TCP socket server. \(message)")
            
                let notification: LocalNotification = LocalNotification(title: "Emergency Alarm", subTitle: "Arduino - ", body: message)
                notification.occurNotification(id: "Arduino-Emergency")
            
            case Stream.Event.endEncountered:
                print("- EndEncountered: new message received.")
            case Stream.Event.errorOccurred:
                print("- ErrorOccurred: error occurred.")
            case Stream.Event.hasSpaceAvailable:
                print("- HasSpaceAvailable: has space available.")
            default: break
        }
    }
}
