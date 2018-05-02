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
    private var group: DispatchGroup = DispatchGroup()
    
    // MARK: - Outlet Variable
    @IBOutlet weak var tempGraph: ScrollableGraphView!
    @IBOutlet weak var humidityGraph: ScrollableGraphView!
    @IBOutlet weak var gasGraph: ScrollableGraphView!
    @IBOutlet weak var noiseGraph: ScrollableGraphView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ParserJSON.parsorInstance.group.notify(queue: .main, execute: {
            
            self.loadingIndicator.stopAnimating()
            
            // MARK: Create ScrollableGraphView
            let graphTemputure: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.temputuerList, labelList: ParserJSON.parsorInstance.dateList)
            graphTemputure.createGraphSheet(graph: self.tempGraph, identifier: "TEMPUTURE", lineColor: .blue, dotColor: .lightcoral)
            
            let graphGas: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.gasList, labelList: ParserJSON.parsorInstance.dateList)
            graphGas.createGraphSheet(graph: self.gasGraph, identifier: "GAS", lineColor: .red, dotColor: .lightcoral)
            
            let graphNoise: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.noiseList, labelList: ParserJSON.parsorInstance.dateList)
            graphNoise.createGraphSheet(graph: self.noiseGraph, identifier: "NOISE", lineColor: .blue, dotColor: .lightcoral)
            
            self.tempGraph.reload()
            self.humidityGraph.reload()
            self.gasGraph.reload()
            self.noiseGraph.reload()
        })
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
