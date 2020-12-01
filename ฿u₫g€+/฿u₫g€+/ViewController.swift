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
    func dayAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("dd")
        return df.string(from: self)
    }
    
    func entireDateAsString() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("dd.MM.yyyy")
        return df.string(from: self)
    }
    var startOfDay: Date {
            return Calendar.current.startOfDay(for: self)
        }

        var startOfMonth: Date {

            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month], from: self)

            return  calendar.date(from: components)!
        }

        var endOfDay: Date {
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startOfDay)!
        }

        var endOfMonth: Date {
            var components = DateComponents()
            components.month = 1
            components.second = -1
            return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
        }
}

let name = "Granwyn Tan"

class ViewController: UIViewController {
    @IBOutlet weak var somethingOutOfSomethingLabel: UILabel!
    @IBOutlet weak var buyALabel: UILabel!
    @IBOutlet weak var savedLabel: UILabel!
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
    @IBOutlet weak var itemName: UILabel!
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
            barView.isHidden = true
            if expensesArray.count != 0 {
                rotateAntiClockWiseBottom.isHidden = false
                rotateAntiClockWiseTop.isHidden = false
                rotateClockWiseBottom.isHidden = false
                rotateClockWiseTop.isHidden = false
                zoomInButton.isHidden = true
                zoomOutButton.isHidden = true
            }
        case 1:
            pieView.isHidden = true
            barView.isHidden = false
            if expensesArray.count != 0 {
                rotateAntiClockWiseBottom.isHidden = true
                rotateAntiClockWiseTop.isHidden = true
                rotateClockWiseBottom.isHidden = true
                rotateClockWiseTop.isHidden = true
                zoomInButton.isHidden = false
                zoomOutButton.isHidden = false
            }
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
//    var window = UIWindow()
    @IBAction func tapWishlistView(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(projectedIncome.loadSampleData())
        projectedIncome.saveToFile(income: projectedIncome.loadSampleData())
        print(projectedIncome.loadFromFile()!)
        print(Date().startOfDay.dayAsString())
        if Date().startOfDay.dayAsString() == "01" {
            if let loadedIncome = projectedIncome.loadFromFile() {
                for i in 0...loadedIncome.count-1 {
                    loadedIncome[i].incomeMoney = 0
                }
                projectedIncome.saveToFile(income: loadedIncome)
            }
//            wishlist = []
//            expensesArray = []
            WishlistItem.saveToFile(wishlist: wishlist)
            expenseStruct.saveToFile(expense: expensesArray)
        }
        wishlistView.isUserInteractionEnabled = true
        spendingsView.layer.cornerRadius = 20
        spendingsView.layer.masksToBounds = true
        savingsView.layer.cornerRadius = 20
        savingsView.layer.masksToBounds = true
        wishlistView.layer.cornerRadius = 20
        wishlistView.layer.masksToBounds = true
        nameLabel.adjustsFontSizeToFitWidth = true
        spendingsView.isUserInteractionEnabled = true
        
//        // light mode FOREVERRRReeeeee
//        UIApplication.shared.windows.forEach { window in
//            window.overrideUserInterfaceStyle = .light
//        }
        // Do any additional setup after loading the view.
        //        var savings = 0.0
        //        for i in 0...expensesArray.count-1 {
        //            savings += (Double(expensesArray[i].projectedExpenses) - expensesArray[i].actualExpenses)
        //        }
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
        nameLabel.text = "Hello, \(name)"
        savedLabel.adjustsFontSizeToFitWidth = true
        buyALabel.adjustsFontSizeToFitWidth = true
        nameLabel.adjustsFontSizeToFitWidth = true
        somethingOutOfSomethingLabel.adjustsFontSizeToFitWidth = true
        updateProjectedSavings()
        updateGlobalSavings()
        updateChart()
        setupBarChart()
        setupPieChart()
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = UIColor(hex: 0x83DB97)
            appearance.backgroundColor = UIColor.systemGreen
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().barTintColor = UIColor(hex: 0x83DB97)
            UINavigationBar.appearance().barTintColor = UIColor.systemGreen
            UINavigationBar.appearance().isTranslucent = false
        }
        spendingsLabel.text = Date().monthAsString()
        if savings > 0 {
            savedLabel.attributedText = NSMutableAttributedString().normal("You have saved ").bold("$\(String(format: "%.2f", savings))").normal(" so far")
        } else {
            savedLabel.attributedText = NSMutableAttributedString().normal("You have saved ").bold("$0").normal(" so far")
        }
        if wishlist.count > 0 {
            let randomItem = wishlist.randomElement()!
            itemName.attributedText = NSMutableAttributedString().bold("\(randomItem.name)")
            if Double(randomItem.price) < Double(savings) {
                buyALabel.attributedText = NSMutableAttributedString().normal20("You have enough to buy this item:")
                //            buyALabel.text = "You can buy a \(randomItem.name)"
                somethingOutOfSomethingLabel.attributedText = NSMutableAttributedString().normal("$").boldBlue("\(String( format: "%.2f", Double(savings)))").normal("/").boldGreen("\(String(format: "%.2f",randomItem.price))")
                //            somethingOutOfSomethingLabel.text = "$\(Int(savings))/$\(randomItem.price)"
    //        } else if randomItem.price == Int(savings) {
    //            buyALabel.attributedText = NSMutableAttributedString().normal20("You have just enough to buy this item:")
    //            //            buyALabel.text = "You can buy a \(randomItem.name)"
    //            somethingOutOfSomethingLabel.attributedText = NSMutableAttributedString().normal("$").boldGreen("\(Int(savings))").normal("/").bold("\(randomItem.price)")
    //            //            somethingOutOfSomethingLabel.text = "$\(Int(savings))/$\(randomItem.price)"
            } else {
                if savings > 0 {
                    buyALabel.attributedText = NSMutableAttributedString().normal20("You need $\(String(format: "%.2f" , Double(randomItem.price)-savings)) more to buy this item:")
                    //            buyALabel.text = "You can buy a \(randomItem.name)"
                    somethingOutOfSomethingLabel.attributedText = NSMutableAttributedString().normal20("$").boldRed("\(String( format: "%.2f", Double(savings)))").normal("/").boldGreen("\(String(format: "%.2f",randomItem.price))")
                    //            somethingOutOfSomethingLabel.text = "$\(Int(savings))/$\(randomItem.price)"
                } else {
                    buyALabel.attributedText = NSMutableAttributedString().normal20("You need $\(String(format: "%.2f" , Double(randomItem.price)-savings)) more to buy this item:")
                    somethingOutOfSomethingLabel.attributedText = NSMutableAttributedString().normal("$").boldBlue("0").normal("/").boldGreen("\(String(format: "%.2f",randomItem.price))")
                }
            }
        } else {
            buyALabel.text = ""
            somethingOutOfSomethingLabel.attributedText = NSMutableAttributedString().normal("")
            itemName.attributedText = NSMutableAttributedString().normal("Wishlist is Empty")
        }
    }
    
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        return .lightContent
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    func setupPieChart() {
        if expensesArray.count != 0 {
            // MARK: Customise Pie Chart
            // Description
            // pieView.usePercentValuesEnabled = true
            pieView.chartDescription?.enabled = false // Disable chartDescription
            // Main CHart
            pieView.drawHoleEnabled = true // Add hole in center
            pieView.rotationAngle = 0 // Set rotation as no offset
            pieView.rotationEnabled = true // Enable rotation
            pieView.centerText = "Expenses/Spendings" // Set centerText to current month
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
        } else {
            pieView.clear()
            pieView.noDataText = "No Data Available for Pie Chart"
            rotateClockWiseTop.isHidden = true
            rotateClockWiseBottom.isHidden = true
            rotateAntiClockWiseTop.isHidden = true
            rotateAntiClockWiseBottom.isHidden = true
        }
    }
    
    func setupBarChart() {
        if expensesArray.count != 0 {
//            zoomInButton.isHidden = false
//            zoomOutButton.isHidden = false
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
            barView.chartDescription?.text = "Expenses/Spendings"
            barView.rightAxis.enabled = false
            //        barView.leftAxis.enabled = false
            //        barView.drawBordersEnabled = false
            barView.xAxis.drawGridLinesEnabled = false
            barView.xAxis.drawAxisLineEnabled = false
            barView.setVisibleYRangeMinimum(0, axis: .left)
            //        barView.leftAxis.drawAxisLineEnabled = false
            //        barView.rightAxis.enabled = false
        } else {
            barView.clear()
            barView.noDataText = "No Data Available for Bar Chart"
            zoomInButton.isHidden = true
            zoomOutButton.isHidden = true
        }
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
        updateChart()
        setupPieChart()
        setupBarChart()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCategory" {
            let destVC = segue.destination as? AddExpensesTableViewController
//            destVC?.sourceViewController = self
        }
    }
}

