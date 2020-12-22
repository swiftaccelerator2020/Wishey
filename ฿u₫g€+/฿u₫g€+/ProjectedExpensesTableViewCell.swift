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
    
    var income: projectedIncome?
    var expense: expenseStruct?
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
        print(incomeArray[theIndexPath.row].incomeMoney)
        incomeName.isHidden = false
        incomeMoney.isHidden = false
        expenseName.isHidden = true
        expenseMoney.isHidden = true
        expenseStepper.isHidden = true
        eDollar.isHidden = true
        iDollar.isHidden = false
        incomeName.text = income?.incomeName
        if let incomeMoneyValue = income?.incomeMoney {
            if incomeMoneyValue < 0 {
                incomeMoney.textColor = .systemRed
                iDollar.textColor = .systemRed
                let alert = UIAlertController(title: "Warning", message: "Projected Savings is less than $0", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Change to Default", style: .default, handler: {_ in
                    
                }))
            } else {
                incomeMoney.textColor = .label
                iDollar.textColor = .label
            }
            incomeMoney.text = "\(incomeMoneyValue)"
        }
        noneLabel.isHidden = true
    }
    
    func expenseSetUp() {
        expenseStepper.value = Double((expense?.projectedExpenses)!)
        incomeName.isHidden = true
        incomeMoney.isHidden = true
        expenseName.isHidden = false
        expenseMoney.isHidden = false
        expenseStepper.isHidden = false
        eDollar.isHidden = false
        iDollar.isHidden = true
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
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        expense?.projectedExpenses = Int(expenseStepper.value)
        tableViewController?.setExpenseMoney(to: Int(expenseStepper.value), of: theIndexPath.row)
//        projectedIncomeArray[2].incomeMoney = (projectedIncomeArray[0].incomeMoney + projectedIncomeArray[1].incomeMoney) - ( projectedExpensesArray[0].expenseMoney + projectedExpensesArray[1].expenseMoney + projectedExpensesArray[2].expenseMoney + projectedExpensesArray[3].expenseMoney )
        //thisTableView.updateTableView()
        
        if expense != nil {
            expenseSetUp()
        } else {
            incomeSetUp()
        }
        expenseStruct.saveToFile(expense: expensesArray)
        projectedIncome.saveToFile(income: incomeArray)
        
        tableViewController?.updateTableView()
        updateProjectedSavings()
    }
    
    @IBAction func changeIncome(_ sender: Any) {
        if incomeMoney.text == nil || incomeMoney.text!.isEmpty || Int(incomeMoney.text!) == nil {
//            print("also yuck")
            income?.incomeMoney = 5000
            incomeArray[theIndexPath.row].incomeMoney = 5000
        } else {
            if Int(incomeMoney.text!)! <= 0 {
                income?.incomeMoney = 5000
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
    
    @IBAction func changeExpense(_ sender: Any) {
        if expenseMoney.text == nil || expenseMoney.text!.isEmpty || Int(expenseMoney.text!) == nil {
            expense?.projectedExpenses = Int((Double(globalincome/expensesArray.count)).rounded(.down))
            expensesArray[theIndexPath.row].projectedExpenses = Int((Double(globalincome/expensesArray.count)).rounded(.down))
        } else {
            if Int(expenseMoney.text!)! <= 0 {
                expense?.projectedExpenses = Int((Double(globalincome/expensesArray.count)).rounded(.down))
                expensesArray[theIndexPath.row].projectedExpenses = Int((Double(globalincome/expensesArray.count)).rounded(.down))
            } else {
                expensesArray[theIndexPath.row].projectedExpenses = Int(expenseMoney.text!)!
            }
        }
        expenseStruct.saveToFile(expense: expensesArray)
        updateProjectedSavings()
        tableViewController?.updateTableView()
    }
}
