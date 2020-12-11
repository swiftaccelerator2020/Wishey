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
    var expense: projectedExpenses?
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expenseMoney.adjustsFontSizeToFitWidth = true
        incomeMoney.adjustsFontSizeToFitWidth = true
        incomeName.adjustsFontSizeToFitWidth = true
        expenseName.adjustsFontSizeToFitWidth = true
    }
    
    func incomeSetUp() {
        incomeName.isHidden = false
        incomeMoney.isHidden = false
        expenseName.isHidden = true
        expenseMoney.isHidden = true
        expenseStepper.isHidden = true
        incomeName.text = income?.incomeName
        if let incomeMoneyValue = income?.incomeMoney {
            incomeMoney.text = "\(incomeMoneyValue)"
        }
        
    }
    
    func expenseSetUp() {
        expenseStepper.value = Double((expense?.expenseMoney)!)
        incomeName.isHidden = true
        incomeMoney.isHidden = true
        expenseName.isHidden = false
        expenseMoney.isHidden = false
        expenseStepper.isHidden = false
        expenseName.text = expense?.expenseName
        if let expenseMoneyValue = expense?.expenseMoney {
            expenseMoney.text = "\(expenseMoneyValue)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        expense?.expenseMoney = Int(expenseStepper.value)
        tableViewController?.setExpenseMoney(to: Int(expenseStepper.value), of: index)
//        projectedIncomeArray[2].incomeMoney = (projectedIncomeArray[0].incomeMoney + projectedIncomeArray[1].incomeMoney) - ( projectedExpensesArray[0].expenseMoney + projectedExpensesArray[1].expenseMoney + projectedExpensesArray[2].expenseMoney + projectedExpensesArray[3].expenseMoney )
        //thisTableView.updateTableView()
        
        if expense != nil {
            expenseSetUp()
        } else {
            incomeSetUp()
        }
        
        tableViewController?.updateTableView()
        updateGlobalSavings()
    }
    
    @IBAction func changeIncome(_ sender: Any) {
        if incomeMoney.text == nil || incomeMoney.text!.isEmpty || Int(incomeMoney.text!) == nil {
//            income?.incomeMoney = 0
            projectedIncomeArray[index].incomeMoney = 0
        } else {
            projectedIncomeArray[index].incomeMoney = Int(incomeMoney.text!)!
        }
        tableViewController?.updateTableView()
    }
    @IBAction func changeExpense(_ sender: Any) {
        if expenseMoney.text == nil || expenseMoney.text!.isEmpty || Int(expenseMoney.text!) == nil{
//            income?.incomeMoney = 0
            projectedExpensesArray[index].expenseMoney = 0
        } else {
            projectedExpensesArray[index].expenseMoney = Int(expenseMoney.text!)!
        }
        tableViewController?.updateTableView()
    }
}
