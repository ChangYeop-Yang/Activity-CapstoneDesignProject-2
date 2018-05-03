//
//  DetailGraph.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 5. 2..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import UIKit
import ScrollableGraphView

// MARK: - Protocol
internal protocol DetailGraphDelegate {
    func isShowWindow()
}

class DetailGraph: UIView {
    
    // MARK: - Outlet Variable
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailGraph: ScrollableGraphView!
    
    // MARK: - Variable
    internal var delegate: DetailGraphDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    // MARK: - Create Graph Method
    internal func createDetailGraph(dateList: [String], dataList: [Double], lable: String, lineColor: UIColor, dotColor: UIColor) {
        
        // Change Lable Text
        detailLabel.text = lable
        
        // Create Detail Graph
        let graph: GraphSet = GraphSet(dataList: dataList, labelList: dateList)
        graph.createGraphSheet(graph: detailGraph, identifier: lable, lineColor: lineColor, dotColor: dotColor)
    }
    
    // MARK: - Action Method
    @IBAction func cancleWindow(_ sender: UIButton) {
        delegate?.isShowWindow()
        self.removeFromSuperview()
    }
}
