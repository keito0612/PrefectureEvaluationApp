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
    
    let activities = ["役所の対応", "交通機関", "住みやすさ", "子育て", "市の制度"]
    
   @Binding var scores:Array<Double>
    
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
        xAxis.labelTextColor = UIColor(cgColor: UIColor.black.cgColor)
        xAxis.drawLabelsEnabled = true
        xAxis.setLabelCount(5, force: true)
        

        let yAxis = chartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 15, weight: .light)
        yAxis.labelTextColor = UIColor(cgColor: UIColor.black.cgColor)
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
        let entries = scores.map {
            RadarChartDataEntry(value: Double($0))}
        let setData = RadarChartDataSet(entries: entries, label: "評価")
        setData.setColor(UIColor(Color.blue))
        setData.fillColor  = UIColor(Color.blue)
        setData.drawHighlightCircleEnabled = true
        setData.setDrawHighlightIndicators(false)
        setData.drawFilledEnabled = true
        setData.fillAlpha = 0.7
        setData.lineWidth = 2
        setData.valueFont  = NSUIFont(descriptor: UIFontDescriptor(name: "20", size: 30) , size: 20)
        uiView.data = RadarChartData(dataSets:[setData])
    }

    func setDataCount() -> ChartData {
        let entries = scores.map { RadarChartDataEntry(value: Double($0)) }
        let setData = RadarChartDataSet(entries: entries, label: "Last Week")
        setData.setColor(UIColor(Color.blue))
        setData.fillColor  = UIColor(Color.blue)
        setData.drawFilledEnabled = true
        setData.valueFont  = NSUIFont(descriptor: UIFontDescriptor(name: "20", size: 20) , size: 30)
        setData.fillAlpha = 0.7
        setData.lineWidth = 2
        setData.drawHighlightCircleEnabled = true
        setData.setDrawHighlightIndicators(false)
        let data: RadarChartData = RadarChartData(dataSets: [setData])
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

