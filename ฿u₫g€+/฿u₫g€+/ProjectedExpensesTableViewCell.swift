//
//  ProjectedExpensesTableViewCell.swift
//  ฿u₫g€+
//
//  Created by Joe Wong on 30/11/20.
//
import UIKit

protocol CustomCellUpdater: class { // the name of the protocol you can put any
    func updateTableView()
}

class ProjectedExpensesTableViewCell: UITableViewCell {
    
    weak var tableViewController: ProjectedExpensesTableViewController?
    
    weak var delegate: CustomCellUpdater?
    
    @IBOutlet weak var expenseMoney: UITextField!
    @IBOutlet weak var expenseStepper: UIStepper!
    @IBOutlet weak var incomeName: UILabel!
    @IBOutlet weak var incomeMoney: UITextField!
    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var iDollar: UILabel!
    @IBOutlet weak var eDollar: UILabel!
    @IBOutlet weak var noneLabel: UILabel!
    @IBOutlet weak var savingsName: UILabel!
    @IBOutlet weak var sDollar: UILabel!
    @IBOutlet weak var savingsMoney: UITextField!
    @IBOutlet weak var sStackView: UIStackView!
    @IBOutlet weak var iStackView: UIStackView!
    @IBOutlet weak var eStackView: UIStackView!
    
    var income: projectedIncome?
    var expense: expenseStruct?
    var saving: projectedSavings?
    var theIndexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expenseMoney.adjustsFontSizeToFitWidth = true
        incomeMoney.adjustsFontSizeToFitWidth = true
        incomeName.adjustsFontSizeToFitWidth = true
        expenseName.adjustsFontSizeToFitWidth = true
    }
    
    func incomeSetUp() {
        eStackView.isHidden = true
        iStackView.isHidden = false
        sStackView.isHidden = true
        print(incomeArray[theIndexPath.row].incomeMoney)
        incomeName.isHidden = false
        incomeMoney.isHidden = false
        expenseName.isHidden = true
        expenseMoney.isHidden = true
        expenseStepper.isHidden = true
        eDollar.isHidden = true
        iDollar.isHidden = false
        sDollar.isHidden = true
        savingsName.isHidden = true
        savingsMoney.isHidden = true
        incomeName.text = income?.incomeName
        if let incomeMoneyValue = income?.incomeMoney {
//            if incomeMoneyValue < 0 {
//                incomeMoney.textColor = .systemRed
//                iDollar.textColor = .systemRed
//                let alert = UIAlertController(title: "Warning", message: "Projected Savings is less than $0", preferredStyle: .actionSheet)
//                alert.addAction(UIAlertAction(title: "Change to Default", style: .default, handler: {_ in
//
//                }))
//            } else {
//                incomeMoney.textColor = .label
//                iDollar.textColor = .label
//            }
            incomeMoney.text = "\(incomeMoneyValue)"
        }
        noneLabel.isHidden = true
    }
    
    func savingsSetUp() {
        eStackView.isHidden = true
        iStackView.isHidden = true
        sStackView.isHidden = false
        incomeName.isHidden = true
        incomeMoney.isHidden = true
        expenseName.isHidden = true
        expenseMoney.isHidden = true
        expenseStepper.isHidden = true
        eDollar.isHidden = true
        iDollar.isHidden = true
        sDollar.isHidden = false
        savingsName.isHidden = false
        savingsMoney.isHidden = false
        savingsName.text = saving?.savingsName
        if let savingsMoneyValue = saving?.savingsMoney {
            if savingsMoneyValue < 0 {
                savingsMoney.textColor = .systemRed
                iDollar.textColor = .systemRed
//                let alert = UIAlertController(title: "Warning", message: "Projected Savings is less than $0", preferredStyle: .actionSheet)
//                alert.addAction(UIAlertAction(title: "Change to Default", style: .default, handler: {_ in
//                    
//                }))
            } else {
                incomeMoney.textColor = .label
                iDollar.textColor = .label
            }
            savingsMoney.text = "\(savingsMoneyValue)"
        }
        noneLabel.isHidden = true
    }
    
    func expenseSetUp() {
        eStackView.isHidden = false
        iStackView.isHidden = true
        sStackView.isHidden = true
        expenseStepper.value = Double((expense?.projectedExpenses)!)
        incomeName.isHidden = true
        incomeMoney.isHidden = true
        expenseName.isHidden = false
        expenseMoney.isHidden = false
        expenseStepper.isHidden = false
        eDollar.isHidden = false
        iDollar.isHidden = true
        sDollar.isHidden = true
        savingsName.isHidden = true
        savingsMoney.isHidden = true
        expenseName.text = expense?.categoryName
        if let expenseProjMoneyValue = expense?.projectedExpenses {
            expenseMoney.text = "\(expenseProjMoneyValue)"
        }
        noneLabel.isHidden = true
    }
    func expenseNoneSetup() {
        noneLabel.isHidden = false
        incomeName.isHidden = true
        incomeMoney.isHidden = true
        expenseName.isHidden = true
        expenseMoney.isHidden = true
        expenseStepper.isHidden = true
        eDollar.isHidden = true
        iDollar.isHidden = true
        sDollar.isHidden = true
        savingsName.isHidden = true
        savingsMoney.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func selectfield(_ sender: Any) {
//        if theIndexPath.section == 0 && theIndexPath.row != 0 && theIndexPath.row != incomeArray.count-1 {
//            
//        }
//    }
    @IBAction func hideKeyboard(_ sender: Any) {
        tableViewController?.resignFirstResponder()
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        expense?.projectedExpenses = Int(expenseStepper.value)
        tableViewController?.setExpenseMoney(to: Int(expenseStepper.value), of: theIndexPath.row)
//        projectedIncomeArray[2].incomeMoney = (projectedIncomeArray[0].incomeMoney + projectedIncomeArray[1].incomeMoney) - ( projectedExpensesArray[0].expenseMoney + projectedExpensesArray[1].expenseMoney + projectedExpensesArray[2].expenseMoney + projectedExpensesArray[3].expenseMoney )
        //thisTableView.updateTableView()
        
        if expense != nil {
            expenseSetUp()
        } else if income != nil {
            incomeSetUp()
        } else {
            savingsSetUp()
        }
        
        expenseStruct.saveToFile(expense: expensesArray)
        projectedIncome.saveToFile(income: incomeArray)
        projectedSavings.saveToFile(savings: savingsArray)
        
        tableViewController?.updateTableView()
        updateProjectedSavings()
    }
    
    @IBAction func changeIncome(_ sender: Any) {
        if incomeMoney.text == nil || incomeMoney.text!.isEmpty || Int(incomeMoney.text!) == nil {
//            print("also yuck")
//            income?.incomeMoney = 5000
            incomeArray[theIndexPath.row].incomeMoney = 5000
        } else {
            if Int(incomeMoney.text!)! <= 0 {
//                income?.incomeMoney = 5000
                incomeArray[theIndexPath.row].incomeMoney = 5000
            } else {
                income?.incomeMoney = Int(incomeMoney.text!)!
                incomeArray[theIndexPath.row].incomeMoney = Int(incomeMoney.text!)!
                print(incomeMoney.text)
                print(incomeArray[theIndexPath.row].incomeMoney)
            }
        }
        projectedIncome.saveToFile(income: incomeArray)
//        updateProjectedSavings()
        updateGlobalSavings()
//        projectedIncome.saveToFile(income: incomeArray)
        if let projectedincomeincomearray = projectedIncome.loadFromFile() {
            for i in projectedincomeincomearray {
                print(i.incomeMoney)
            }
        }
        tableViewController?.updateTableView()
    }
    
    @IBAction func changeSavings(_ sender: Any) {
        if savingsMoney.text == nil || savingsMoney.text!.isEmpty || Int(savingsMoney.text!) == nil {
//            print("also yuck")
//            savings.savingsMoney = 5000
            savingsArray[theIndexPath.row].savingsMoney = 5000
        } else {
            if Int(savingsMoney.text!)! <= 0 {
//                savings.savingsMoney = 5000
                savingsArray[theIndexPath.row].savingsMoney = 5000
            } else {
//                savings.savingsMoney = Int(savingsMoney.text!)!
                savingsArray[theIndexPath.row].savingsMoney = Int(savingsMoney.text!)!
                print(savingsMoney.text)
                print(savingsArray[theIndexPath.row].savingsMoney)
            }
        }
        updateProjectedSavings()
        updateGlobalSavings()
        projectedIncome.saveToFile(income: incomeArray)
        projectedSavings.saveToFile(savings: savingsArray)
        if let projectedincomeincomearray = projectedIncome.loadFromFile() {
            for i in projectedincomeincomearray {
                print(i.incomeMoney)
            }
        }
        tableViewController?.updateTableView()
    }
    
    @IBAction func changeExpense(_ sender: Any) {
        if expenseMoney.text == nil || expenseMoney.text!.isEmpty || Int(expenseMoney.text!) == nil {
            if UserDefaults.standard.object(forKey: "savingsTarget") != nil {
                expense?.projectedExpenses = Int((Double((globalincome-UserDefaults.standard.integer(forKey: "savingsTarget"))/expensesArray.count)).rounded(.down))
                expensesArray[theIndexPath.row].projectedExpenses = Int((Double((globalincome-UserDefaults.standard.integer(forKey: "savingsTarget"))/expensesArray.count)).rounded(.down))
            } else {
                expense?.projectedExpenses = Int((Double(globalincome/expensesArray.count)).rounded(.down))
                expensesArray[theIndexPath.row].projectedExpenses = Int((Double(globalincome/expensesArray.count)).rounded(.down))
            }
        } else {
            if Int(expenseMoney.text!)! <= 0 {
                if UserDefaults.standard.object(forKey: "savingsTarget") != nil {
                    expense?.projectedExpenses = Int((Double((globalincome-UserDefaults.standard.integer(forKey: "savingsTarget"))/expensesArray.count)).rounded(.down))
                    expensesArray[theIndexPath.row].projectedExpenses = Int((Double((globalincome-UserDefaults.standard.integer(forKey: "savingsTarget"))/expensesArray.count)).rounded(.down))
                } else {
                    expense?.projectedExpenses = Int((Double(globalincome/expensesArray.count)).rounded(.down))
                    expensesArray[theIndexPath.row].projectedExpenses = Int((Double(globalincome/expensesArray.count)).rounded(.down))
                }
            } else {
                expensesArray[theIndexPath.row].projectedExpenses = Int(expenseMoney.text!)!
            }
        }
        expenseStruct.saveToFile(expense: expensesArray)
        updateProjectedSavings()
        tableViewController?.updateTableView()
    }
}
