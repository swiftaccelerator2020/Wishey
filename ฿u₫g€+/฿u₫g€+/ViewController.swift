//
//  ViewController.swift
//  ฿u₫g€+
//
//  Created by Swift Accelator 2020 Group 3 on 26/11/20.
//

import UIKit
import Charts

extension Date {
    func monthAsString() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMMM")
            return df.string(from: self)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var pieView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupPieChart()
    }
    
    func setupPieChart() {
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = true
        pieView.rotationAngle = 0
        pieView.rotationEnabled = true
        pieView.centerText = Date().monthAsString()
        pieView.drawSlicesUnderHoleEnabled = true
        pieView.drawCenterTextEnabled = true
        pieView.isUserInteractionEnabled = true
        /*
        pieView.legend.enabled = false
 */
        pieView.legend.horizontalAlignment = .center
        pieView.legend.textColor = .label
        pieView.legend.wordWrapEnabled = true
        pieView.backgroundColor = .systemBackground
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: 600.00, label: "Healthcare"))
        entries.append(PieChartDataEntry(value: 500.00, label: "Transport"))
        entries.append(PieChartDataEntry(value: 400.00, label: "Food"))
        entries.append(PieChartDataEntry(value: 300.00, label: "Gaming"))
        entries.append(PieChartDataEntry(value: 200.00, label: "Entertainment"))
        entries.append(PieChartDataEntry(value: 100.00, label: "Others"))
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
//        let c1 = NSUIColor(hex: 0x3A015C)
//        let c2 = NSUIColor(hex: 0x4F0147)
//        let c3 = NSUIColor(hex: 0x35012C)
//        let c4 = NSUIColor(hex: 0x290025)
//        let c5 = NSUIColor(hex: 0x11001C)
        
//        dataSet.colors = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemBlue,  .systemIndigo, .systemPurple]
        dataSet.colors =
           ChartColorTemplates.material()
                + ChartColorTemplates.joyful()
                + ChartColorTemplates.colorful()
                + ChartColorTemplates.pastel()
        dataSet.drawValuesEnabled = true
        pieView.data = PieChartData(dataSet: dataSet)
    }
}

