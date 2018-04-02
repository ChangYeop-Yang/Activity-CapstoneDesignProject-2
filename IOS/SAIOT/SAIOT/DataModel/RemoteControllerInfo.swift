//
//  RemotecontrollerInfo.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 2..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import RealmSwift

class RemoteControllerInfo: Object {
    
    // MARK: - Integer Value
    @objc dynamic var channelType: Int = 0
    
    // MARK: - String Value
    @objc dynamic var name: String = ""
    @objc dynamic var remoteType: String = ""
    
    // MARK: - Date Value
    @objc dynamic var createTime: Date = Date()
}
