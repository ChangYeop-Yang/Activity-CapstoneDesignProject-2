//
//  HomeViewController.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 4..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import SwiftyHue
import ScrollableGraphView

class HomeViewController: UIViewController {
    
    // MARK: - Variable
    private var isSubView: Bool = false
    private var temputureArray = [Int]()
    private var humdityArray = [Int]()
    private var gasArray = [Int]()
    private var noiseArray = [Int]()
    
    // MARK: - Outlet Variable
    @IBOutlet weak var tempGraph: ScrollableGraphView!
    @IBOutlet weak var humidityGraph: ScrollableGraphView!
    @IBOutlet weak var gasGraph: ScrollableGraphView!
    @IBOutlet weak var noiseGraph: ScrollableGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let datas: [Double] = [11.32, 34.23, 25.61, 36.15, 27.54, 19.63, 16.54, 29.43, 11.23, 24.33]
        let string: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        
        ParserJSON.parsorInstance.parsorSensorDataJSON(url: "http://yeop9657.duckdns.org/select.php")
        
        // MARK: Create Graph
        let graphTemputure: GraphSet = GraphSet(dataList: datas, labelList: string)
        graphTemputure.createGraphSheet(graph: tempGraph, identifier: "TEMPUTURE", lineColor: .blue, dotColor: .lightcoral)
        
        let graphHumidity: GraphSet = GraphSet(dataList: datas, labelList: string)
        graphHumidity.createGraphSheet(graph: humidityGraph, identifier: "HUMIDITY", lineColor: .brown, dotColor: .lightcoral)
        
        let graphGas: GraphSet = GraphSet(dataList: datas, labelList: string)
        graphGas.createGraphSheet(graph: gasGraph, identifier: "GAS", lineColor: .red, dotColor: .lightcoral)
        
        let graphNoise: GraphSet = GraphSet(dataList: datas, labelList: string)
        graphNoise.createGraphSheet(graph: noiseGraph, identifier: "NOISE", lineColor: .blue, dotColor: .lightcoral)
    }
    
    // MARK: - Outlet Action Method
    @IBAction func ShowDetailHueMent(_ sender: UILongPressGestureRecognizer) {
        
        if (isSubView == false) {
            
            UIView.animate(withDuration: 1, animations: {
                
                let detailView = UINib(nibName: "DetailHue", bundle: nil).instantiate(withOwner: self, options: nil).first as! DetailHue
                detailView.delegate = self
                detailView.center = self.view.center
                self.view.addSubview(detailView)
            }, completion: nil)
            
            isSubView = true
        }
        
    }
}

// MAKR: - DetailHue Delegate Extension
extension HomeViewController: DetailHueDelegate {
    
    func closeSubView() {
        isSubView = false
    }
}
