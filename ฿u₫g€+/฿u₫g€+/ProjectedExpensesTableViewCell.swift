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
    
    weak var delegate: CustomCellUpdater?
    
    @IBOutlet weak var expenseMoney: UILabel!
    @IBOutlet weak var expenseStepper: UIStepper!
    @IBOutlet weak var incomeMoney: UILabel!
    @IBOutlet weak var incomeName: UILabel!
    @IBOutlet weak var expenseName: UILabel!
    
    var income: projectedIncome?
    var expense: projectedExpenses?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func incomeSetUp() {
        incomeName.isHidden = false
        incomeMoney.isHidden = false
        expenseName.isHidden = true
        expenseMoney.isHidden = true
        expenseStepper.isHidden = true
        incomeName.text = income?.incomeName ?? ""
        if let incomeMoneyValue = income?.incomeMoney {
            incomeMoney.text = "$\(incomeMoneyValue)"
        }
        
    }
    
    func expenseSetUp() {
        expenseStepper.value = Double(expense?.expenseMoney ?? 0)
        incomeName.isHidden = true
        incomeMoney.isHidden = true
        expenseName.isHidden = false
        expenseMoney.isHidden = false
        expenseStepper.isHidden = false
        expenseName.text = expense?.expenseName
        if let expenseMoneyValue = expense?.expenseMoney {
            expenseMoney.text = "$\(expenseMoneyValue)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        expense?.expenseMoney = Int(expenseStepper.value)
        projectedIncomeArray[2].incomeMoney = (projectedIncomeArray[0].incomeMoney + projectedIncomeArray[1].incomeMoney) - ( projectedExpensesArray[0].expenseMoney + projectedExpensesArray[1].expenseMoney + projectedExpensesArray[2].expenseMoney + projectedExpensesArray[3].expenseMoney )
        print(projectedIncomeArray[2].incomeMoney)
        if expense != nil {
            expenseSetUp()
        } else {
            incomeSetUp()
            
        }
        
    }
    
}
