//
//  KitxhenSensor.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 2..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import RealmSwift

class RemoteList: Object {
    
    // MARK: - Date Value
    @objc dynamic var usedDate: Date = Date()
    
    // MARK: - Strign Value
    @objc dynamic var hueBridgeName: String = ""
    @objc dynamic var hubBridgeIP: String = ""
    
    // MARK: - List
    let controllerList = List<RemoteControllerInfo>()
}
