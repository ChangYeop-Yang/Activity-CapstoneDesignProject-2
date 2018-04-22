//
//  PhilipsHueBridge.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 18..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import SwiftyHue

// MARK: - PhilipsHueBridge Delegate
internal protocol HueBridgeDelegate: class {
    var hueAccessConfig: BridgeAccessConfig { get set }
}

class PhilipsHueBridge: NSObject {
    
    // MARK: - Variable
    fileprivate var hueBridge: HueBridge?
    private weak var delegate: HueBridgeDelegate?
    
}

// MARK: - BridgeFinderDelegate Extension
extension PhilipsHueBridge: BridgeFinderDelegate {
    
    func bridgeFinder(_ finder: BridgeFinder, didFinishWithResult bridges: [HueBridge]) {
        
        if let bridge: HueBridge = bridges.first {
            hueBridge = bridge
            print("Bridge IP: \(bridge.ip), Bridge NAME: \(bridge.modelName), Bridge Serial: \(bridge.serialNumber)")
        }
    }
}

// MAKR: - BridgeAuthenticatorDelegate Extension
extension PhilipsHueBridge: BridgeAuthenticatorDelegate {
    
    func bridgeAuthenticator(_ authenticator: BridgeAuthenticator, didFinishAuthentication username: String) {
        
        if let bridge: HueBridge = hueBridge {
            
            delegate?.hueAccessConfig = BridgeAccessConfig(bridgeId: bridge.modelName, ipAddress: bridge.ip, username: username)
        }
    }
    
    func bridgeAuthenticator(_ authenticator: BridgeAuthenticator, didFailWithError error: NSError) {
        <#code#>
    }
    
    func bridgeAuthenticatorRequiresLinkButtonPress(_ authenticator: BridgeAuthenticator, secondsLeft: TimeInterval) {
        
    }
    
    func bridgeAuthenticatorDidTimeout(_ authenticator: BridgeAuthenticator) {
        <#code#>
    }
}
