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
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
    
    @IBOutlet weak var barView: BarChartView!
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    struct DataEntry {
        var value: Double
        var name: String
    }
    
    var data: [DataEntry] = []
    
    @IBAction func pageControlChangeValue(_ sender: Any) {
        updateChart()
    }
    
    func updateChart() {
        switch pageControl.currentPage {
        case 0:
            pieView.isHidden = false
            barView.isHidden = true
        case 1:
            pieView.isHidden = true
            barView.isHidden = false
        default:
            break
        }
    }
    
//    func checkPage(numberOfPages no: Int) -> [Int]{
//        var hiddenPages: [Int] = []
//        for i in 0...no {
//            hiddenPages.append(i)
//        }
//        switch pageControl.currentPage {
//        case 0:
//            setupPieChart()
//        case 1:
//            setupBarChart()
//        case 2:
//            setupLineChart()
//        default:
//            break
//        }
//        hiddenPages.remove(at: pageControl.currentPage)
//        return hiddenPages
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateChart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        data = []
        data.append(DataEntry(value: 600.00, name: "Healthcare"))
        data.append(DataEntry(value: 500.00, name: "Transport"))
        data.append(DataEntry(value: 400.00, name: "Food"))
        data.append(DataEntry(value: 300.00, name: "Gaming"))
        data.append(DataEntry(value: 200.00, name: "Entertainment"))
        data.append(DataEntry(value: 100.00, name: "Others"))
        setupBarChart()
        setupPieChart()
    }
    
    func setupPieChart() {
        // MARK: Customise Pie Chart
        // Description
        pieView.chartDescription?.enabled = false // Disable chartDescription
        // Main CHart
        pieView.drawHoleEnabled = true // Add hole in center
        pieView.rotationAngle = 0 // Set rotation as no offset
        pieView.rotationEnabled = true // Enable rotation
        pieView.centerText = Date().monthAsString() // Set centerText to current month
        pieView.drawSlicesUnderHoleEnabled = false // Turn off slices under hole, text is more to the outside
        pieView.drawCenterTextEnabled = true // Allow center text
        pieView.isUserInteractionEnabled = true // Enlarges on tap
        // pieView.legend.enabled = false
        // Legend
        pieView.legend.horizontalAlignment = .center // set alignment of text to center
        pieView.legend.textColor = .label // cent text color to default label color
        pieView.legend.wordWrapEnabled = true // allow word wrapping
        pieView.backgroundColor = .systemBackground // set background color to default background color
        // MARK: Set Data for Pie Chart
        // Set up array
        var pieEntries: [PieChartDataEntry] = []
        // Iterate through data values
        for item in data {
            pieEntries.append(PieChartDataEntry(value: item.value, label: item.name))
        }
//        entries.append(PieChartDataEntry(value: 600.00, label: "Healthcare"))
//        entries.append(PieChartDataEntry(value: 500.00, label: "Transport"))
//        entries.append(PieChartDataEntry(value: 400.00, label: "Food"))
//        entries.append(PieChartDataEntry(value: 300.00, label: "Gaming"))
//        entries.append(PieChartDataEntry(value: 200.00, label: "Entertainment"))
//        entries.append(PieChartDataEntry(value: 100.00, label: "Others"))
        let pieDataSet = PieChartDataSet(entries: pieEntries, label: nil)
        pieDataSet.colors =
           ChartColorTemplates.material()
                + ChartColorTemplates.joyful()
                + ChartColorTemplates.colorful()
                + ChartColorTemplates.pastel() // Add more colors using pre defined libraries
//        pieDataSet.colors = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemTeal, .systemBlue,  .systemIndigo, .systemPurple]
//        pieDataSet.colors = colorsOfCharts(numbersOfColor: pieDataSet.count)
//        let c1 = NSUIColor(hex: 0x3A015C)
//        let c2 = NSUIColor(hex: 0x4F0147)
//        let c3 = NSUIColor(hex: 0x35012C)
//        let c4 = NSUIColor(hex: 0x290025)
//        let c5 = NSUIColor(hex: 0x11001C)
        pieDataSet.drawValuesEnabled = true
        pieView.data = PieChartData(dataSet: pieDataSet)
    }
    
    func setupBarChart() {
        var barEntries: [BarChartDataEntry] = []
        var xAxisValues: [String] = []
        var yAxisValues: [String] = []
        for item in 0..<data.count {
            barEntries.append(BarChartDataEntry(x: Double(item), yValues: [data[item].value]))
            xAxisValues.append(data[item].name)
        }
        let chartDataSet = BarChartDataSet(entries: barEntries, label: nil)
        chartDataSet.colors =
           ChartColorTemplates.material()
                + ChartColorTemplates.joyful()
                + ChartColorTemplates.colorful()
                + ChartColorTemplates.pastel() // Add more colors using pre defined libraries
        let chartData = BarChartData(dataSet: chartDataSet)
//        barView.drawBarShadowEnabled = true
        barView.drawGridBackgroundEnabled = false
        barView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisValues)
        barView.xAxis.labelPosition = .bottom
        barView.xAxis.granularityEnabled = true
        barView.xAxis.granularity = 1
        barView.data = chartData
        barView.data?.setDrawValues(false)
        barView.pinchZoomEnabled = true
        barView.scaleYEnabled = true
        barView.scaleXEnabled = true
//        barView.highlighter = nil
        barView.doubleTapToZoomEnabled = true
        barView.chartDescription?.text = Date().monthAsString()
        barView.rightAxis.enabled = false
//        barView.leftAxis.enabled = false
        barView.drawBordersEnabled = false
        barView.xAxis.drawGridLinesEnabled = false
//        barView.xAxis.drawAxisLineEnabled = false
//        barView.leftAxis.drawAxisLineEnabled = false
//        barView.rightAxis.enabled = false
        barView.
    }
    func setupLineChart() {
        
    }
}

