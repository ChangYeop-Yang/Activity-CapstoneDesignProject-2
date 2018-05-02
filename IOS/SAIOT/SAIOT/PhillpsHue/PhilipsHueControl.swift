//
//  PhilipsHueControl.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 18..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import SwiftyHue

class PhilipsHueControl: NSObject {
    
    // MARK: - Variable
    private var swiftyHue: SwiftyHue = SwiftyHue()
    
    internal init(config: BridgeAccessConfig) {
        swiftyHue.setBridgeAccessConfig(config)
    }
    
    // MARK: - Philips Hue Method
    internal func changeHueColor(red: Int, green: Int, blue: Int, alpha: Int) {
        
        guard let lights = swiftyHue.resourceCache?.lights else {
            
            print("Error, Not Load the philips hue lights.")
            return
        }
        
        // Change Light Color State loop
        for light in lights {
            
            let colorXY = HueUtilities.calculateXY(UIColor.init(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha)), forModel: light.key)
            
            var lightState: LightState = LightState()
            lightState.brightness = alpha
            lightState.xy = [Float(colorXY.x), Float(colorXY.y)]
            
            swiftyHue.bridgeSendAPI.updateLightStateForId(light.key, withLightState: lightState, completionHandler: {
                error in print("Error, Not Change the philips hue light color.")
            })
        }
    }
}
