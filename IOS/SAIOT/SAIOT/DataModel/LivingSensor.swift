//
//  LivingSensor.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 2..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import RealmSwift

class LivingSensor: Object {
    
    // MARK: - Date Value
    @objc dynamic var collectDate: Date = Date()
    @objc dynamic var occurSparkDate: Date = Date()
    
    // MARK: - Integer Value
    @objc dynamic var temputure: Int = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var noise: Int = 0
    @objc dynamic var gas: Int = 0
}
