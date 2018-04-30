//
//  GraphSet.swift
//  SAIOT
//
//  Created by 양창엽 on 2018. 4. 30..
//  Copyright © 2018년 Yang-Chang-Yeop. All rights reserved.
//

import ScrollableGraphView

class GraphSet: NSObject {
    
    // MARK: - Variable
    fileprivate var graphCollectList: (Datas: [Double], Names: [String]) = ( [Double](), [String]() )
    
    // MARK: - Init
    internal init(dataList: [Double], labelList: [String]) {
        graphCollectList.Datas = dataList
        graphCollectList.Names = labelList
    }
    
    // MARK: Create ScrollableGraphView Method
    internal func createGraphSheet(graph: ScrollableGraphView, identifier: String, lineColor: UIColor, dotColor: UIColor) {
        
        // Setting ScrollableGraphView
        graph.dataSource = self
        graph.shouldAnimateOnStartup = true
        graph.shouldAdaptRange = true
        graph.shouldRangeAlwaysStartAtZero = true
        
        // Insert Plot and Reference
        let attribute = convertAttribute(identifier: identifier, lineColor: lineColor, dotColor: dotColor)
        graph.addReferenceLines(referenceLines: attribute.Reference)
        graph.addPlot(plot: attribute.Line)
        graph.addPlot(plot: attribute.Dots)
    }
    
    // MARK: Convert Data Plot to Array Method
    private func convertAttribute(identifier: String, lineColor: UIColor, dotColor: UIColor) -> (Line: LinePlot, Reference: ReferenceLines, Dots: DotPlot) {
        
        // LinePlot
        let linePlot: LinePlot = LinePlot(identifier: identifier)
        linePlot.lineColor = lineColor
        linePlot.lineWidth = 3
        linePlot.adaptAnimationType = .elastic
        linePlot.lineStyle = .smooth
        
        // DotPlot
        let dotPlot: DotPlot = DotPlot(identifier: identifier + "Dot")
        dotPlot.dataPointType = .circle
        dotPlot.dataPointSize = 2
        dotPlot.dataPointFillColor = dotColor
        
        // Reference Line
        let referenceLines: ReferenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(1)
        
        return (linePlot, referenceLines, dotPlot)
    }
}

// MARK: - ScrollableGraphViewDataSource Extension
extension GraphSet: ScrollableGraphViewDataSource {
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return graphCollectList.Datas[pointIndex]
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return graphCollectList.Names[pointIndex]
    }
    
    func numberOfPoints() -> Int {
        return graphCollectList.Datas.count
    }
}
