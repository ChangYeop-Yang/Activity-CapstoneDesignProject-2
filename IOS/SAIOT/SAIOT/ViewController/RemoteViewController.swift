//
//  RemoteViewController.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 4..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import AudioToolbox

// MARK: - Enum
private enum ColorHUE: Int {
    case RedHUE = 100
    case GreenHUE = 200
    case BlueHUE = 300
    case PinkHUE = 400
}

class RemoteViewController: UIViewController {
    
    // MARK: - Variable
    private var isPower: Bool = false
    
    // MARK: - Outlet Variable
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func controlTotalPower(_ sender: UIButton) {
        
        // Control Philips Hue Bulb Power
        if PhilipsHueBridge.hueInstance.connectHueBridge() {
            isPower = !isPower
            PhilipsHueBridge.hueInstance.changeHuePower(power: isPower)
        }
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    // MARK: - Change Philips Hue Bulb Action Method
    @IBAction func changeColorHUE(_ sender: UIButton) {
        
        guard PhilipsHueBridge.hueInstance.connectHueBridge() else {
            if let pressView = UINib(nibName: NibName.PressHueBridge.rawValue, bundle: nil).instantiate(withOwner: self, options: nil).first as? PressHueBridge {
                pressView.center = self.view.center
                self.view.addSubview(pressView)
            }
            return
        }
        
        if let tagHUE: ColorHUE = ColorHUE(rawValue: sender.tag) {
            switch tagHUE {
            case .RedHUE:
                PhilipsHueBridge.hueInstance.changeHueColor(red: 255, green: 0, blue: 0, alpha: 255)
            case .GreenHUE:
                PhilipsHueBridge.hueInstance.changeHueColor(red: 0, green: 255, blue: 0, alpha: 255)
            case .BlueHUE:
                PhilipsHueBridge.hueInstance.changeHueColor(red: 0, green: 0, blue: 255, alpha: 255)
            case .PinkHUE:
                PhilipsHueBridge.hueInstance.changeHueColor(red: 255, green: 0, blue: 255, alpha: 255)
            }
        }
        
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
}
