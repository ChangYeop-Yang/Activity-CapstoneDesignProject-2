//
//  ParserStruct.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 1..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import Foundation

internal enum jsonName: String {
    case date = "Insert_DT"
    case temputure = "AVG(Temp_NO)"
    case cds = "AVG(Cmd_NO)"
    case noise = "AVG(Noise_NO)"
    case flare = "Flare_FL"
    case gas = "AVG(Gas_FL)"
    case clientIP = "IP_ID"
}
