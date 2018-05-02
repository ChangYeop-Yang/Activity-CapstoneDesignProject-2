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
    internal var group: DispatchGroup = DispatchGroup()
    internal var temputuerList: [Double] = [Double]()
    internal var cdsList: [Double] = [Double]()
    internal var noiseList: [Double] = [Double]()
    internal var gasList: [Double] = [Double]()
    internal var dateList: [String] = [String]()
    
    // MARK: - get Instance Method
    private override init() {}
    
    // MARK: - Parsor JSON Method
    internal func parsorSensorDataJSON(url: String) {
        
        // MARK: Check Nil Server URL
        guard let httpURL: URL = URL(string: url) else {
            print("Error, Server URL Empty.")
            return
        }
        
        let defaultSession = URLSession(configuration: .default)
        let urlTask = defaultSession.dataTask(with: URLRequest(url: httpURL), completionHandler: { [weak self] (data, response, error) in
            
            guard error == nil else {
                print("Error, HTTP Request: \(String(describing: error))")
                return
            }
            
            do {
                guard let jsonData = data else {
                    print("Error, HTTP Request Data Empty.")
                    return
                }
                
                let jsonSerialized = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String : Any]
                if let sensorDatas = jsonSerialized["SensorDatas"] as? [[String:Any]]  {
                    
                    for item in sensorDatas {
                        
                        // Processing Save Json
                        self?.temputuerList.append( Double(item[jsonName.temputure.rawValue] as! String)! )
                        self?.noiseList.append( Double(item[jsonName.noise.rawValue] as! String)! )
                        self?.gasList.append( Double(item[jsonName.gas.rawValue] as! String)! )
                        self?.cdsList.append( Double(item[jsonName.cds.rawValue] as! String)! )
                        
                        // Processing Dateformatter
                        let formatter: DateFormatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        if let insertDT: Date = formatter.date(from: item[jsonName.date.rawValue] as! String) {
                            let hour = Calendar.current.component(.hour, from: insertDT)
                            let minute = Calendar.current.component(.minute, from: insertDT)
                            self?.dateList.append("\(hour):\(minute)")
                        }
                    }
                    self?.group.leave()
                }
            } catch let jsonError as NSError {
                print("Failed to load: \(jsonError)")
            }
        })
        
        // DispatchQueue
        group.enter()
        DispatchQueue.main.async(group: group, execute: {
            urlTask.resume()
        })
    }
}
