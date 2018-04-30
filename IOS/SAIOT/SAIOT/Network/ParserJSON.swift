//
//  ParserJSON.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 30..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import Foundation

final class ParserJSON: NSObject {
    
    // MARK: - Variable
    internal static let parsorInstance: ParserJSON = ParserJSON()
    
    // MARK: - get Instance Method
    private override init() {}
    
    // MARK: - Parsor JSON Method
    internal func parsorSensorDataJSON(url: String) {
        
        // MARK: Check Nil Server URL
        guard let httpURL: URL = URL(string: url) else {
            print("Error, Server URL Empty.")
            return
        }
        
        DispatchQueue.global(qos: .userInteractive).async { [weak weakSelf = self] in
            
            URLSession.shared.dataTask(with: httpURL) { (data, response, error) in
                // Check Error and Empty Parsing Data
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonSerialized)
            }.resume()
        }
    }
}
