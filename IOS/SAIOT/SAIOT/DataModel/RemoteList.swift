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
    
    // MARK: - Integer Value
    @objc dynamic var hue: Int = 0
    @objc dynamic var colors: [Int] = [0, 0, 0]
    
    // MARK: - String Value
    @objc dynamic var hueBridgeID: String = ""
    @objc dynamic var hueBridgeIP: String = ""
    @objc dynamic var hueBridgeName: String = ""
    
    // MARK: - List
    let controllerList = List<RemoteControllerInfo>()
}
