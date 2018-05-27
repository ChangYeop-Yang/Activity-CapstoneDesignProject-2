//
//  DefaultsKeys.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 24..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import Foundation

// MARK: - Variables
internal let userDefaults: UserDefaults = UserDefaults.standard

// MARK: - Enum UserDefaults Key Value
internal enum DefaultsKey: String {
    case AlarmKey = "ALARM_KEY"
    case HuePowerKey = "HUE_TOTAL_POWER_KEY"
    case MonitorKey = "MONITOR_KEY"
    case SmartBoxAddressKey = "SMART_BOX_ADDRESS_KEY"
    case SocketAddressKey = "SOCKET_ADDRESS_KEY"
}
