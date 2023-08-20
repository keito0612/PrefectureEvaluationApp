//
//  RaderChat.swift
//  PrefectureEvaluationApp
//
//  Created by 磯部馨仁 on 2023/08/07.
//

import Foundation
import SwiftUI
import DGCharts

struct RadarChart: UIViewRepresentable {
    
    typealias UIViewType = RadarChartView
    
    let activities = ["役所の対応", "交通機関", "住みやすさ", "子育て", "物価"]
    
    
    func makeUIView(context: Context) -> RadarChartView {
        let chartView = RadarChartView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        let chartFormatter = RadarChartFormatter(labels: activities)
        chartView.rotationEnabled = false
        chartView.chartDescription.enabled = false
        chartView.webLineWidth = 1
        chartView.innerWebLineWidth = 1
        chartView.webColor = .lightGray
        chartView.innerWebColor = .lightGray
        chartView.webAlpha = 1
        chartView.minOffset = 0
        
        let xAxis = chartView.xAxis
        
        xAxis.labelFont = .systemFont(ofSize: 13, weight: .light)
       
        xAxis.valueFormatter = chartFormatter as AxisValueFormatter
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.labelTextColor = UIColor(cgColor: UIColor.white.cgColor)
        xAxis.drawLabelsEnabled = true
        xAxis.setLabelCount(5, force: true)
        

        let yAxis = chartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 15, weight: .light)
        yAxis.labelTextColor = UIColor(cgColor: UIColor.white.cgColor)
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 5
        yAxis.setLabelCount(5, force: true)
        yAxis.drawLabelsEnabled = true

        let l = chartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xEntrySpace = 7
        l.yEntrySpace = 5

        chartView.data = setDataCount()

        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)

        return chartView
    }

    func updateUIView(_ uiView: RadarChartView, context: Context) {
    }

    func setDataCount() -> ChartData {
        let mult: UInt32 = 5
        let min: UInt32 = 0
        let cnt = 5

        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        let entries1 = (0..<cnt).map(block)
        let entries2 = (0..<cnt).map(block)

        let set1 = RadarChartDataSet(entries: entries1, label: "Last Week")
        set1.setColor(UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1))
        set1.fillColor = UIColor(red: 103/255, green: 110/255, blue: 129/255, alpha: 1)
        set1.drawFilledEnabled = true
        set1.valueFont  = NSUIFont(descriptor: UIFontDescriptor(name: "20", size: 20) , size: 10)
        set1.fillAlpha = 0.7
        set1.lineWidth = 2
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        set1.valueFont  = NSUIFont(descriptor: UIFontDescriptor(name: "20", size: 20) , size: 10)
        let set2 = RadarChartDataSet(entries: entries2, label: "This Week")
        set2.setColor(UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1))
        set2.fillColor = UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.7
        set2.lineWidth = 2
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)

        let data: RadarChartData = RadarChartData(dataSets: [set1, set2])
        data.setValueFont(.systemFont(ofSize: 8, weight: .light))
        data.setDrawValues(false)

        return data
    }
}

private class RadarChartFormatter: NSObject, AxisValueFormatter {
    
    var labels: [String] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if Int(value) < labels.count {
            return labels[Int(value)]
        }else{
            return String("")
        }
    }
    
    init(labels: [String]) {
        super.init()
        self.labels = labels
    }
}

