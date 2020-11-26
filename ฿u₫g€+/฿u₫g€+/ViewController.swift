//
//  ViewController.swift
//  ฿u₫g€+
//
//  Created by Joe Wong on 26/11/20.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var pieView: PieChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupPieChart()
    }
    //MARK: DO NOT TOUCH FUNCTION
    func setupPieChart() {
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = false
        pieView.rotationAngle = 0
        pieView.rotationEnabled = true
        pieView.isUserInteractionEnabled = true
        /*
        pieView.legend.enabled = false
 */
        pieView.legend.horizontalAlignment = .center
        pieView.backgroundColor = .systemBackground
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: 50.0, label: "Healthcare"))
        entries.append(PieChartDataEntry(value: 40.0, label: "Transport"))
        entries.append(PieChartDataEntry(value: 30.0, label: "Food"))
        entries.append(PieChartDataEntry(value: 20.0, label: "Gaming"))
        entries.append(PieChartDataEntry(value: 10.0, label: "Entertainment"))
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        let c1 = NSUIColor(hex: 0x3A015C)
        let c2 = NSUIColor(hex: 0x4F0147)
        let c3 = NSUIColor(hex: 0x35012C)
        let c4 = NSUIColor(hex: 0x290025)
        let c5 = NSUIColor(hex: 0x11001C)
        
        dataSet.colors = [c1, c2, c3, c4, c5]
        dataSet.drawValuesEnabled = false
        
        pieView.data = PieChartData(dataSet: dataSet)
    }
}

