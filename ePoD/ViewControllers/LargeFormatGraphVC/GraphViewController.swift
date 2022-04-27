//
//  GraphViewController.swift
//  ePoD
//
//  Created by Tyler Goudie on 5/26/20.
//  Copyright © 2020 Tyler Goudie. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {

    var chartView = LineChartView()
    var dataPoints = Array(repeating: 0, count: lrgGraphDataPointSize)
    var setupValues = Array(repeating: 0.0, count: lrgGraphDataPointSize)
    var dataPointSelector = 4

        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            self.setupLineChart(dataPoints: dataPoints, values: setupValues)
            self.primeDataPointSize()
            
            
            // Timer for updating and plotting new graph data
            Timer.scheduledTimer(withTimeInterval: 0.025, repeats: true) { [weak self]_ in
                guard let self = self else {return}
                DispatchQueue.main.async {
                    
                    
                    self.primeDataPointSize()
                    
                    
                }
            }
        }
        
    func primeDataPointSize(){

        switch largeGraphSelected {
        case 0:
            lrgGraphDataPointSize = accelZData.count
            self.dataPointSelector = 5
            self.primeDataPoints()
            self.updateChartData(dataPoints: self.dataPoints, values: accelZData)
            break
        case 1:
            lrgGraphDataPointSize = accelYData.count
            self.dataPointSelector = 4
            self.primeDataPoints()
            self.updateChartData(dataPoints: self.dataPoints, values: accelYData)
            break
        case 2:
            lrgGraphDataPointSize = accelXData.count
            self.dataPointSelector = 3
            self.primeDataPoints()
            self.updateChartData(dataPoints: self.dataPoints, values: accelXData)
            break
        case 3:
            lrgGraphDataPointSize = heartRateBPM.count
            self.dataPointSelector = 2
            self.primeDataPoints()
            self.updateChartData(dataPoints: self.dataPoints, values: heartRateBPM)
            break
        case 4:
            lrgGraphDataPointSize = heartRatePPG.count
            self.dataPointSelector = 1
            self.primeDataPoints()
            self.updateChartData(dataPoints: self.dataPoints, values: heartRatePPG)
            break
        case 5:
            lrgGraphDataPointSize = sp02Data.count
            self.dataPointSelector = 0
            self.primeDataPoints()
            self.updateChartData(dataPoints: self.dataPoints, values: sp02Data)
            break
            
        default:
            break
        }
    }
    
        // creates and array of data points AKA x-Axis for graph
        func primeDataPoints(){
            dataPoints = Array(repeating: 0, count: lrgGraphDataPointSize)
            switch dataPointSelector {
            case 0:
                for i in 0..<sp02Data.count{
                    dataPoints[i] = i
                }
                break
            case 1:
                for i in 0..<heartRatePPG.count{
                    dataPoints[i] = i
                }
                break
            case 2:
                for i in 0..<heartRateBPM.count{
                    dataPoints[i] = i
                }
                break
            case 3:
                for i in 0..<accelXData.count{
                    dataPoints[i] = i
                }
                break
            case 4:
                for i in 0..<accelYData.count{
                    dataPoints[i] = i
                }
                break
            case 5:
                for i in 0..<accelZData.count{
                    dataPoints[i] = i
                }
                break
            default:
                break
            }

        }
        
        //MARK: Line Chart Setup
        func setupLineChart(dataPoints: [Int] ,values: [Double]){
            
            self.view.addSubview(chartView)
            //chartView.delegate = self as! ChartViewDelegate
            chartView.translatesAutoresizingMaskIntoConstraints = false
            chartView.frame = CGRect(x: 0, y: 0, width: screenSize.height - 80, height: screenSize.width - 80)
            
            chartView.isUserInteractionEnabled = true
            chartView.backgroundColor = .clear
            chartView.legend.enabled = false
            chartView.dragEnabled = true
            
            let xAxis = chartView.xAxis
            xAxis.labelPosition = .bottom
            xAxis.labelFont = .systemFont(ofSize: 14)
            xAxis.labelTextColor = .black
            xAxis.drawAxisLineEnabled = true
            xAxis.centerAxisLabelsEnabled = true
            xAxis.granularityEnabled = true
            xAxis.drawGridLinesEnabled = true
            //xAxis.valueFormatter = DateIntervalFormatter()
            
            let lAxis = chartView.leftAxis
            lAxis.labelPosition = .outsideChart
            lAxis.labelFont = .systemFont(ofSize: 8)
            
            lAxis.labelTextColor = .black
            lAxis.drawAxisLineEnabled = true
            lAxis.centerAxisLabelsEnabled = true
            lAxis.granularityEnabled = true
            lAxis.drawGridLinesEnabled = true
            
            chartView.rightAxis.enabled = false
            
            
            var lineDataEntry: [ChartDataEntry] = []
            for i in 0..<dataPoints.count{
                let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
                lineDataEntry.append(dataPoint)
            }
            
            let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "Top Graph")
            let chartData = LineChartData()
            chartData.addDataSet(chartDataSet)
            chartData.setDrawValues(false)
            chartDataSet.colors = [.black]
            chartDataSet.circleColors = [.systemBlue]
            chartDataSet.circleRadius = 4.0
            chartDataSet.mode = .horizontalBezier
            chartDataSet.cubicIntensity = 0.025
            chartDataSet.drawCirclesEnabled = false
            chartDataSet.valueFont = UIFont(name: "Helvetica", size: 16)!
            let colors = [colorFF3802.cgColor, colorD17379.cgColor]as CFArray
            let colorLocations:[CGFloat] = [1.0,0.0]
            let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors , locations: colorLocations)
            chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
            chartDataSet.drawFilledEnabled = false
            
            chartView.data = chartData
        }
        
        //MARK: Line Chart Updating
        func updateChartData(dataPoints: [Int] ,values: [Double]){
            var lineDataEntry: [ChartDataEntry] = []
            for i in 0..<dataPoints.count{
                let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i]))
                lineDataEntry.append(dataPoint)
            }
            
            let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "Top Graph")
            let chartData = LineChartData()
            chartData.addDataSet(chartDataSet)
            chartData.setDrawValues(false)
            chartDataSet.colors = [.black]
            chartDataSet.circleColors = [.systemBlue]
            chartDataSet.circleRadius = 4.0
            chartDataSet.mode = .horizontalBezier
            chartDataSet.cubicIntensity = 0.025
            chartDataSet.drawCirclesEnabled = false
            chartDataSet.valueFont = UIFont(name: "Helvetica", size: 16)!
            let colors = [colorFF3802.cgColor, colorD17379.cgColor]as CFArray
            let colorLocations:[CGFloat] = [1.0,0.0]
            let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors , locations: colorLocations)
            chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
            chartDataSet.drawFilledEnabled = false
            
            chartView.data = chartData
            
        }
        
    }

