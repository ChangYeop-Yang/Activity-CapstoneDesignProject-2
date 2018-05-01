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
    
    // MARK: - Outlet Variable
    @IBOutlet weak var tempGraph: ScrollableGraphView!
    @IBOutlet weak var humidityGraph: ScrollableGraphView!
    @IBOutlet weak var gasGraph: ScrollableGraphView!
    @IBOutlet weak var noiseGraph: ScrollableGraphView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempGraph.reload()
        humidityGraph.reload()
        gasGraph.reload()
        noiseGraph.reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !ParserJSON.parsorInstance.dateList.isEmpty {
            print(ParserJSON.parsorInstance.temputuerList)
            // MARK: Create Graph
            let graphTemputure: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.temputuerList, labelList: ParserJSON.parsorInstance.dateList)
            graphTemputure.createGraphSheet(graph: tempGraph, identifier: "TEMPUTURE", lineColor: .blue, dotColor: .lightcoral)
            
            let graphGas: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.gasList, labelList: ParserJSON.parsorInstance.dateList)
            graphGas.createGraphSheet(graph: gasGraph, identifier: "GAS", lineColor: .red, dotColor: .lightcoral)
            
            let graphNoise: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.noiseList, labelList: ParserJSON.parsorInstance.dateList)
            graphNoise.createGraphSheet(graph: noiseGraph, identifier: "NOISE", lineColor: .blue, dotColor: .lightcoral)
            
            tempGraph.reload()
            humidityGraph.reload()
            gasGraph.reload()
            noiseGraph.reload()
        }
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
