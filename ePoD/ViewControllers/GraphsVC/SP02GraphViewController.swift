//
//  SP02GraphViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 3/19/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit
import Charts

class SP02GraphViewController: UIViewController {

    var chartView = LineChartView()
    var dataPoints = Array(repeating: 0, count: sp02Data.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.primeDataPoints()
        self.setupLineChart(dataPoints: dataPoints, values: sp02Data)
        self.updateChartData(dataPoints: dataPoints, values: sp02Data)
        
        // Timer for updating and plotting new graph data
        Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { [weak self]_ in
            guard let self = self else {return}
            DispatchQueue.main.async {
                //print("Timer")
                self.primeDataPoints()
                self.updateChartData(dataPoints: self.dataPoints, values: sp02Data)
                //self.chartView.animate(xAxisDuration: 0.5)
            }
        }
    }
    // creates and array of data points AKA x-Axis for graph
    func primeDataPoints(){
        var i = 0
        while i < sp02Data.count{
            dataPoints[i] = i
            i = i+1
        }
    }
    //MARK: Line Chart Setup
    func setupLineChart(dataPoints: [Int] ,values: [Double]){
        
        self.view.addSubview(chartView)
        //chartView.delegate = self as! ChartViewDelegate
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.frame = CGRect(x: 0, y: 0, width: screenSize.width-70, height: screenSize.height/4 - 50)
        
        
        chartView.isUserInteractionEnabled = false
        chartView.backgroundColor = .clear
        chartView.legend.enabled = false
        chartView.dragEnabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 8)
        xAxis.labelTextColor = .white
        xAxis.drawAxisLineEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularityEnabled = true
        xAxis.drawGridLinesEnabled = false
        //xAxis.valueFormatter = DateIntervalFormatter()
        
        let lAxis = chartView.leftAxis
        lAxis.labelPosition = .outsideChart
        lAxis.labelFont = .systemFont(ofSize: 8)
        
        lAxis.labelTextColor = .white
        lAxis.drawAxisLineEnabled = false
        lAxis.centerAxisLabelsEnabled = true
        lAxis.granularityEnabled = true
        lAxis.drawGridLinesEnabled = false
        
        chartView.rightAxis.enabled = false
        
        var lineDataEntry: [ChartDataEntry] = []
        for i in 0..<dataPoints.count{
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "SP02")
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
        let colors = [color5B16C8.cgColor, colorD6BBF9.cgColor]as CFArray
        let colorLocations:[CGFloat] = [1.0,0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors , locations: colorLocations)
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        chartDataSet.drawFilledEnabled = true
        
        
        chartView.data = chartData
        
    }
    
    //MARK: Line Chart Updating
    func updateChartData(dataPoints: [Int] ,values: [Double]){
        var lineDataEntry: [ChartDataEntry] = []
        for i in 0..<dataPoints.count{
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "SP02")
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
        let colors = [color5B16C8.cgColor, colorD6BBF9.cgColor]as CFArray
        let colorLocations:[CGFloat] = [1.0,0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors , locations: colorLocations)
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        chartDataSet.drawFilledEnabled = true
        
        chartView.data = chartData
        
    }
}
