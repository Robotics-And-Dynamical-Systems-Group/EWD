//
//  HeartRateGraph.swift
//  ePoD
//
//  Created by Tyler Goudie on 3/5/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//
import Foundation
import UIKit
import Charts


class HeartRateGraph: LineChartView {

    let HrGraphView = LineChartView()
    var lineDataEntry: [ChartDataEntry] = []
    var dataPoints = Array(repeating: 0, count: 244)
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           primeDataPoints()
            lineChartSetup()
       }
    override init(frame: CGRect) {
           super.init(frame: frame)
            
           primeDataPoints()
           lineChartSetup()
       }
    
    
   
    func primeDataPoints(){
        var i = 0
        while i < 244{
            dataPoints[i] = i
            i = i+1
        }
    }
    
    func lineChartSetup(){
        //print("Line Chart Setup")
        self.backgroundColor = .clear
        self.addSubview(HrGraphView)
        
        HrGraphView.translatesAutoresizingMaskIntoConstraints = false
        HrGraphView.frame = CGRect(x: 0, y: 0, width: screenSize.width-70, height: screenSize.height/4 - 50)
        
        //Line Chart Animation
        HrGraphView.animate(xAxisDuration: 0.5, yAxisDuration: 0, easing: nil)
        
        // Line Chart Population
        //setLineChart(dataPoints: dataPoints, values: heartRate)

    }
    
    func setLineChart(dataPoints: [Int] ,values: [Double]){
        //No Data Setup
        HrGraphView.noDataTextColor = UIColor.red
        HrGraphView.noDataText = "No Data Availible"
        HrGraphView.noDataFont = UIFont(name: "Helvetica", size: 25)!
        HrGraphView.backgroundColor = .clear
        
        //Data Point Setup and Coloring
        //print(values)
        for i in 0..<dataPoints.count{
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "Heart Rate")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(false)
        chartDataSet.colors = [.white]
        chartDataSet.circleColors = [UIColor.green]
        chartDataSet.circleRadius = 4.0
        chartDataSet.mode = .horizontalBezier
        chartDataSet.cubicIntensity = 0.25
        chartDataSet.drawCirclesEnabled = false
        chartDataSet.valueFont = UIFont(name: "Helvetica", size: 12)!
        let colors = [colorFF3802.cgColor, colorD17379.cgColor]as CFArray
        let colorLocations:[CGFloat] = [1.0,0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors , locations: colorLocations)
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        chartDataSet.drawFilledEnabled = true
        //chartDataSet.notifyDataSetChanged()
        
        //Axis Setup
        HrGraphView.xAxis.labelPosition = .bottom
        HrGraphView.xAxis.drawLabelsEnabled = true
        HrGraphView.xAxis.drawGridLinesEnabled = false
        HrGraphView.chartDescription?.enabled = false
        HrGraphView.legend.enabled = false
        HrGraphView.rightAxis.enabled = false
        HrGraphView.leftAxis.drawGridLinesEnabled = false
        HrGraphView.leftAxis.drawLabelsEnabled = true
        HrGraphView.data = chartData
        
        
            

    }

}
