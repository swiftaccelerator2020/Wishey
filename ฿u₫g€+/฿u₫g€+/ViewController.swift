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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rotateClockWiseTop: UIButton!
    @IBOutlet weak var rotateAntiClockWiseTop: UIButton!
    @IBOutlet weak var rotateClockWiseBottom: UIButton!
    @IBOutlet weak var rotateAntiClockWiseBottom: UIButton!
    @IBOutlet weak var barView: BarChartView!
    @IBOutlet weak var wishlistView: UIView!
    @IBOutlet weak var spendingsView: UIView!
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var savingsView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var spendingsLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var zoomInButton: UIButton!
    @IBOutlet weak var zoomOutButton: UIButton!
    @IBOutlet var swipeLeftGesture: UISwipeGestureRecognizer!
    @IBOutlet var swipeRightGesture: UISwipeGestureRecognizer!
    
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
    
    @IBAction func pageControlChangeValue(_ sender: Any) {
        updateChart()
    }
    
    func updateChart() {
        switch pageControl.currentPage {
        case 0:
            pieView.isHidden = false
            rotateAntiClockWiseBottom.isHidden = false
            rotateAntiClockWiseTop.isHidden = false
            rotateClockWiseBottom.isHidden = false
            rotateClockWiseTop.isHidden = false
            barView.isHidden = true
            zoomInButton.isHidden = true
            zoomOutButton.isHidden = true
        case 1:
            pieView.isHidden = true
            barView.isHidden = false
            rotateAntiClockWiseBottom.isHidden = true
            rotateAntiClockWiseTop.isHidden = true
            rotateClockWiseBottom.isHidden = true
            rotateClockWiseTop.isHidden = true
            zoomInButton.isHidden = false
            zoomOutButton.isHidden = false
        default:
            break
        }
    }
    
    func resetCurrentChart() {
        switch pageControl.currentPage {
        case 0:
            pieView.rotationAngle = 0
            pieView.highlightValues(nil)
        case 1:
            barView.fitScreen()
            barView.highlightValues(nil)
            barView.resetZoom()
            barView.resetViewPortOffsets()
        default:
            break
        }
    }
    
    @IBAction func rotateClockWise(_ sender: Any) {
        pieView.rotationAngle += 10
    }
    
    @IBAction func rotateAntiClockWise(_ sender: Any) {
        pieView.rotationAngle -= 10
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
        spendingsView.layer.cornerRadius = 20
        spendingsView.layer.masksToBounds = true
        savingsView.layer.cornerRadius = 20
        savingsView.layer.masksToBounds = true
        wishlistView.layer.cornerRadius = 20
        wishlistView.layer.masksToBounds = true
        nameLabel.adjustsFontSizeToFitWidth = true
        spendingsView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        
//        scrollView.contentOffset = CGPoint(x: 0, y: 0)
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
//        self.navigationController?.navigationBar.sizeToFit()
//        scrollView.scrollsToTop = true
//        scrollView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top, left: view.safeAreaInsets.left, bottom: view.safeAreaInsets.bottom, right: view.safeAreaInsets.right)
//        scrollView.clipsToBounds = true
//        view.update
//        scrollView?.alwaysBounceVertical = true
//        setNeedsStatusBarAppearanceUpdate()
//        if #available(iOS 13.0, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = UIColor(hex: 0x83DB97)
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().compactAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        } else {
//            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().barTintColor = UIColor(hex: 0x83DB97)
//            UINavigationBar.appearance().isTranslucent = false
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateChart()
        setupBarChart()
        setupPieChart()
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(hex: 0x83DB97)
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = UIColor(hex: 0x83DB97)
            UINavigationBar.appearance().isTranslucent = false
        }
        spendingsLabel.text = Date().monthAsString()
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func setupPieChart() {
        // MARK: Customise Pie Chart
        // Description
//        pieView.usePercentValuesEnabled = true
        pieView.chartDescription?.enabled = false // Disable chartDescription
        // Main CHart
        pieView.drawHoleEnabled = true // Add hole in center
        pieView.rotationAngle = 0 // Set rotation as no offset
        pieView.rotationEnabled = true // Enable rotation
        pieView.centerText = "Spendings" // Set centerText to current month
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
        for i in expensesArray {
            pieEntries.append(PieChartDataEntry(value: i.actualExpenses, label: i.categoryName))
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
        
        let pieChartData = PieChartData(dataSet: pieDataSet)
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .percent
//        formatter.maximumFractionDigits = 1
//        formatter.multiplier = 1.0
//        pieChartData.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        pieView.data = pieChartData
    }
    
    func setupBarChart() {
        var barEntries: [BarChartDataEntry] = []
        var xAxisValues: [String] = []
        for i in 0..<expensesArray.count {
            barEntries.append(BarChartDataEntry(x: Double(i), yValues: [expensesArray[i].actualExpenses]))
            xAxisValues.append(expensesArray[i].categoryName)
        }
        let chartDataSet = BarChartDataSet(entries: barEntries, label: nil)
        chartDataSet.colors =
           ChartColorTemplates.material()
                + ChartColorTemplates.joyful()
                + ChartColorTemplates.colorful()
                + ChartColorTemplates.pastel() // Add more colors using pre defined libraries
        let chartData = BarChartData(dataSet: chartDataSet)
//        barView.drawBarShadowEnabled = true
//        barView.drawGridBackgroundEnabled = false
        barView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisValues)
        barView.xAxis.labelPosition = .bottom
        barView.xAxis.granularityEnabled = true
        barView.xAxis.granularity = 1
        barView.data = chartData
//        barView.data?.setDrawValues(false)
        barView.pinchZoomEnabled = true
        barView.scaleYEnabled = true
        barView.scaleXEnabled = true
//        barView.highlighter = nil
        barView.drawValueAboveBarEnabled = true
        barView.doubleTapToZoomEnabled = true
        barView.chartDescription?.text = "Spendings"
        barView.rightAxis.enabled = false
//        barView.leftAxis.enabled = false
//        barView.drawBordersEnabled = false
        barView.xAxis.drawGridLinesEnabled = false
        barView.xAxis.drawAxisLineEnabled = false
        barView.setVisibleYRangeMinimum(0, axis: .left)
//        barView.leftAxis.drawAxisLineEnabled = false
//        barView.rightAxis.enabled = false
        
    }
    
//    func setupLineChart() {
//
//    }
    @IBAction func resetChart(_ sender: Any) {
        resetCurrentChart()
    }
    @IBAction func zoomIn(_ sender: Any) {
        barView.zoomIn()
    }
    @IBAction func zoomOut(_ sender: Any) {
        barView.zoomOut()
    }
    @IBAction func tapChart(_ sender: Any) {
        performSegue(withIdentifier: "showExpenses", sender: nil)
    }
    @IBAction func addExpensesCategoryHome(_ sender: Any) {
        performSegue(withIdentifier: "addCategory", sender: nil)
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        if pageControl.currentPage > 0 {
            pageControl.currentPage -= 1
            updateChart()
        }
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        if pageControl.currentPage < pageControl.numberOfPages-1 {
            pageControl.currentPage += 1
            updateChart()
        }
    }
    
    @IBAction func unwindToHome( _ seg: UIStoryboardSegue) {
        setupPieChart()
        setupBarChart()
    }  
}
