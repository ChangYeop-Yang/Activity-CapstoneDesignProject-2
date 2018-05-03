//
//  HomeViewController.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 4..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import SwiftyHue
import AudioToolbox
import ScrollableGraphView

// MARK: - Enum
private enum NibName: String {
    case DetailHue = "DetailHue"
    case DetailGraph = "DetailGraph"
    case PressHueBridge = "PressHueBridge"
}
private enum GraphLabel: String {
    case GraphTemputuer = "TEMPUTURE"
    case GraphCDS = "CDS"
    case GraphGas = "GAS"
    case GraphNoise = "NOISE"
}

class HomeViewController: UIViewController {
    
    // MARK: - Variable
    private var isSubView: Bool = false
    
    // MARK: - Outlet Variable
    @IBOutlet weak var tempGraph: ScrollableGraphView!
    @IBOutlet weak var cdsGraph: ScrollableGraphView!
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
            
            let graphCDS: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.cdsList, labelList: ParserJSON.parsorInstance.dateList)
            graphCDS.createGraphSheet(graph: self.cdsGraph, identifier: "CDS", lineColor: .blue, dotColor: .lightcoral)
            
            let graphGas: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.gasList, labelList: ParserJSON.parsorInstance.dateList)
            graphGas.createGraphSheet(graph: self.gasGraph, identifier: "GAS", lineColor: .blue, dotColor: .lightcoral)
            
            let graphNoise: GraphSet = GraphSet(dataList: ParserJSON.parsorInstance.noiseList, labelList: ParserJSON.parsorInstance.dateList)
            graphNoise.createGraphSheet(graph: self.noiseGraph, identifier: "NOISE", lineColor: .blue, dotColor: .lightcoral)            
        })
    }
    
    // MARK: - Method
    private func createDetailGraphView(nibName: String, label: String, dates: [String], datas: [Double], lineColor: UIColor, dotColor: UIColor) {
        
        // Vibrate
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        // Create Nib File
        UIView.animate(withDuration: 1, animations: {
            if let detailView = UINib(nibName: nibName, bundle: nil).instantiate(withOwner: self, options: nil).first as? DetailGraph {
                detailView.delegate = self
                detailView.center = self.view.center
                detailView.createDetailGraph(dateList: dates, dataList: datas, lable: label, lineColor: lineColor, dotColor: dotColor)
                self.view.addSubview(detailView)
            }
        })
    }
    private func createDetailHueView() -> Bool {

        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

        if PhilipsHueBridge.hueInstance.connectHueBridge() {
            
            UIView.animate(withDuration: 1, animations: {
                // Create Nib File
                if let detailView = UINib(nibName: NibName.DetailHue.rawValue, bundle: nil).instantiate(withOwner: self, options: nil).first as? DetailHue {
                    detailView.delegate = self
                    detailView.center = self.view.center
                    self.view.addSubview(detailView)
                }
            })
        } else {
            if let pressView = UINib(nibName: NibName.PressHueBridge.rawValue, bundle: nil).instantiate(withOwner: self, options: nil).first as? PressHueBridge {
                pressView.center = self.view.center
                self.view.addSubview(pressView)
                return false
            }
        }
        
        return true
    }
    
    // MARK: - Outlet Action Method
    @IBAction func ShowDetailHueMent(_ sender: UILongPressGestureRecognizer) {
        
        if !isSubView {
            isSubView = createDetailHueView()
        }
    }
    @IBAction func longPressCDSDetailGraph(_ sender: UILongPressGestureRecognizer) {
        if !isSubView {
            createDetailGraphView(nibName: NibName.DetailGraph.rawValue, label: GraphLabel.GraphCDS.rawValue, dates: ParserJSON.parsorInstance.dateList, datas: ParserJSON.parsorInstance.cdsList, lineColor: .red, dotColor: .black)
            isSubView = true
        }
    }
    @IBAction func longPressTemputureDetailGraph(_ sender: UILongPressGestureRecognizer) {
        if !isSubView {
            createDetailGraphView(nibName: NibName.DetailGraph.rawValue, label: GraphLabel.GraphTemputuer.rawValue, dates: ParserJSON.parsorInstance.dateList, datas: ParserJSON.parsorInstance.temputuerList, lineColor: .red, dotColor: .black)
            isSubView = true
        }
    }
    @IBAction func longPressGasDetailGraph(_ sender: UILongPressGestureRecognizer) {
        if !isSubView {
            createDetailGraphView(nibName: NibName.DetailGraph.rawValue, label: GraphLabel.GraphGas.rawValue, dates: ParserJSON.parsorInstance.dateList, datas: ParserJSON.parsorInstance.gasList, lineColor: .red, dotColor: .black)
            isSubView = true
        }
    }
    @IBAction func longPressNoiseDetailGraph(_ sender: UILongPressGestureRecognizer) {
        if !isSubView {
            createDetailGraphView(nibName: NibName.DetailGraph.rawValue, label: GraphLabel.GraphNoise.rawValue, dates: ParserJSON.parsorInstance.dateList, datas: ParserJSON.parsorInstance.noiseList, lineColor: .red, dotColor: .black)
            isSubView = true
        }
    }
}

// MARK: - DetailHue Delegate Extension
extension HomeViewController: DetailHueDelegate {
    
    func closeSubView() {
        isSubView = false
    }
}

// MARK: - DetailGraph Delegate Extension
extension HomeViewController: DetailGraphDelegate {
    
    func isShowWindow() {
        isSubView = false
    }
}
