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
        incomeName.text = income?.incomeName
        if let incomeMoneyValue = income?.incomeMoney {
            if incomeMoneyValue <= 0 {
                incomeMoney.textColor = .red
            } else {
                incomeMoney.textColor = .label
            }
            incomeMoney.text = "\(incomeMoneyValue)"
        }
    }
    
    func expenseSetUp() {
        expenseStepper.value = Double((expense?.projectedExpenses)!)
        incomeName.isHidden = true
        incomeMoney.isHidden = true
        expenseName.isHidden = false
        expenseMoney.isHidden = false
        expenseStepper.isHidden = false
        expenseName.text = expense?.categoryName
        if let expenseProjMoneyValue = expense?.projectedExpenses {
            expenseMoney.text = "\(expenseProjMoneyValue)"
        }
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
            expense?.projectedExpenses = 100
            expensesArray[theIndexPath.row].projectedExpenses = 100
        } else {
            if Int(expenseMoney.text!)! <= 0 {
                expense?.projectedExpenses = 100
                expensesArray[theIndexPath.row].projectedExpenses = 100
            } else {
                expensesArray[theIndexPath.row].projectedExpenses = Int(expenseMoney.text!)!
            }
        }
        expenseStruct.saveToFile(expense: expensesArray)
        updateProjectedSavings()
        tableViewController?.updateTableView()
    }
}
