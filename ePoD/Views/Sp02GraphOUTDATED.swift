//
//  Sp02Graph.swift
//  ePoD
//
//  Created by Tyler Goudie on 2/23/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import Foundation
import Charts
import UIKit

class SP02Graph: UIView {
    // Cubic Line Properties
    let Sp02GraphView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    var dataPoints = [Int]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        primeDataPoints()
        cubicLineChartSetup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        primeDataPoints()
        cubicLineChartSetup()
    }
    
    func primeDataPoints(){
        for i in 0..<sp02Data.count{
            dataPoints.append(i)
        }
    }
    
    func cubicLineChartSetup(){
        //Line Chart Config
        self.backgroundColor = UIColor.clear
        self.addSubview(Sp02GraphView)
        Sp02GraphView.translatesAutoresizingMaskIntoConstraints = false
        Sp02GraphView.frame = CGRect(x: 0, y: 0, width: screenSize.width-70, height: screenSize.height/4 - 50)
        
        // Line Chart Animation
        Sp02GraphView.animate(xAxisDuration: 0.5, yAxisDuration: 0, easing: nil)
        
        //Line Chart Population
        //setCubicLineChart(dataPoints: dataPoints, values: sp02Data )
    }
    
    func setCubicLineChart(dataPoints: [Int], values: [Int]){
        //No Data Setup
        Sp02GraphView.noDataTextColor = UIColor.red
        Sp02GraphView.noDataText = "No Data Availible"
        Sp02GraphView.noDataFont = UIFont(name: "Helvetica", size: 25)!
        Sp02GraphView.backgroundColor = .clear
        
        //Data Point Setup and Coloring
        for i in 0..<dataPoints.count{
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "Sp02")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(false)
        chartDataSet.colors = [.white]
        chartDataSet.circleColors = [UIColor.green]
        chartDataSet.circleRadius = 4.0
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.3
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.valueFont = UIFont(name: "Helvetica", size: 12)!
        let colors = [color5B16C8.cgColor, colorD6BBF9.cgColor]as CFArray
        let colorLocations:[CGFloat] = [1.0,0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors , locations: colorLocations)
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        chartDataSet.drawFilledEnabled = true
        
        //Axis Setup
        Sp02GraphView.xAxis.labelPosition = .bottom
        Sp02GraphView.xAxis.drawLabelsEnabled = true
        Sp02GraphView.xAxis.drawGridLinesEnabled = false
        Sp02GraphView.chartDescription?.enabled = false
        Sp02GraphView.legend.enabled = false
        Sp02GraphView.rightAxis.enabled = false
        Sp02GraphView.leftAxis.drawGridLinesEnabled = false
        Sp02GraphView.leftAxis.drawLabelsEnabled = true
        Sp02GraphView.data = chartData
    
        
    }
    
}
